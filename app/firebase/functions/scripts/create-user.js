#!/usr/bin/env node
// Create (or update) a CMS login: a Firebase Auth email/password account plus its
// CMS profile casinos/{casinoId}/users/{uid} with a role. Uses the Admin SDK, so it
// bypasses the app's sign-up flow and approval queue — run it only as a project owner.
//
//   cd app/firebase/functions && npm install
//   npm run create:admin -- --project dev  --email admin@cms4cas.store --name "Thanh Nguyen"
//   npm run create:user  -- --project prod --email floor@cms4cas.store --name "Floor 1" --role pit_supervisor
//
// Options
//   --project <dev|prod|projectId>   required; dev/prod are read from ../.firebaserc
//   --email <email>                  required
//   --name <full name>               required for new accounts
//   --role <role>                    admin | casino_manager | pit_supervisor | cage_cashier |
//                                    credit_executive | compliance_officer | marketing | auditor
//   --credit-role <role|none>        signing authority (Table 6.2): president | vp_finance |
//                                    casino_manager | credit_manager | shift_manager | host | cage_director.
//                                    Omitted: an existing user keeps theirs. "none" removes it.
//   --casino <id>                    default "main" (must match --dart-define=CASINO_ID)
//   --password-reset-link            don't set a password; print a link the person uses to choose one
//   --password <pw>                  set the password non-interactively (ends up in shell history —
//                                    prefer the prompt or --password-reset-link)
//   --update-password                for an existing account, also replace its password
//   --service-account <file.json>    otherwise Application Default Credentials are used
//                                    (gcloud auth application-default login)
//
// Emulators: set FIREBASE_AUTH_EMULATOR_HOST and FIRESTORE_EMULATOR_HOST; no credentials needed.
'use strict';

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore } = require('firebase-admin/firestore');
const { ROLES, CREDIT_ROLES } = require('../src/roles');

const MIN_PASSWORD = 8; // same as the app's registration form

function parseArgs(argv) {
  const out = {};
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (!a.startsWith('--')) throw new Error(`Unexpected argument: ${a}`);
    const key = a.slice(2);
    const next = argv[i + 1];
    if (next === undefined || next.startsWith('--')) out[key] = true;
    else { out[key] = next; i++; }
  }
  return out;
}

function resolveProject(p) {
  if (!p || p === true) throw new Error('--project is required (dev, prod or a project id).');
  const rc = path.join(__dirname, '..', '..', '.firebaserc');
  if (fs.existsSync(rc)) {
    const aliases = (JSON.parse(fs.readFileSync(rc, 'utf8')).projects) || {};
    if (aliases[p]) return aliases[p];
  }
  if (p === 'dev' || p === 'prod') throw new Error(`Alias "${p}" not found in ${rc}. Run app/tool/firebase_setup.sh first.`);
  return p;
}

function askHidden(question) {
  return new Promise((resolve, reject) => {
    if (!process.stdin.isTTY) return reject(new Error('No terminal for a password prompt: use --password-reset-link or --password.'));
    const rl = readline.createInterface({ input: process.stdin, output: process.stdout, terminal: true });
    rl._writeToOutput = (s) => { if (s.startsWith(question)) rl.output.write(s); }; // don't echo
    rl.question(question, (answer) => { rl.close(); process.stdout.write('\n'); resolve(answer); });
  });
}

async function choosePassword(args) {
  if (typeof args.password === 'string') return args.password;
  const pw = await askHidden('Password: ');
  const again = await askHidden('Repeat password: ');
  if (pw !== again) throw new Error('The passwords do not match.');
  return pw;
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const projectId = resolveProject(args.project);
  const email = typeof args.email === 'string' ? args.email.trim().toLowerCase() : '';
  const name = typeof args.name === 'string' ? args.name.trim() : '';
  const role = args.role;
  const creditArg = typeof args['credit-role'] === 'string' ? args['credit-role'] : undefined; // undefined = keep
  const casinoId = typeof args.casino === 'string' ? args.casino : 'main';
  const resetLink = args['password-reset-link'] === true;

  if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) throw new Error('--email must be a valid email address.');
  if (!ROLES.includes(role)) throw new Error(`--role must be one of: ${ROLES.join(', ')}`);
  if (creditArg !== undefined && creditArg !== 'none' && !CREDIT_ROLES.includes(creditArg)) {
    throw new Error(`--credit-role must be one of: ${CREDIT_ROLES.join(', ')}, none`);
  }

  const usingEmulators = !!(process.env.FIREBASE_AUTH_EMULATOR_HOST && process.env.FIRESTORE_EMULATOR_HOST);
  const options = { projectId };
  if (!usingEmulators) {
    options.credential = typeof args['service-account'] === 'string'
      ? cert(JSON.parse(fs.readFileSync(args['service-account'], 'utf8')))
      : applicationDefault();
  }
  initializeApp(options);
  const auth = getAuth();
  const db = getFirestore();

  console.log(`▸ ${usingEmulators ? 'EMULATORS' : 'Firebase project'} ${projectId} · casino "${casinoId}"`);

  let user = null;
  try { user = await auth.getUserByEmail(email); } catch (e) { if (e.code !== 'auth/user-not-found') throw e; }

  let created = false;
  if (!user) {
    if (name.length < 2) throw new Error('--name is required for a new account.');
    const password = resetLink ? undefined : await choosePassword(args);
    if (password !== undefined && password.length < MIN_PASSWORD) throw new Error(`Use at least ${MIN_PASSWORD} characters for the password.`);
    // Created by an owner, so the address is trusted.
    user = await auth.createUser({ email, displayName: name, password, emailVerified: true, disabled: false });
    created = true;
  } else {
    const update = {};
    if (name && name !== user.displayName) update.displayName = name;
    if (args['update-password'] === true) {
      const password = await choosePassword(args);
      if (password.length < MIN_PASSWORD) throw new Error(`Use at least ${MIN_PASSWORD} characters for the password.`);
      update.password = password;
    }
    if (Object.keys(update).length) user = await auth.updateUser(user.uid, update);
  }

  const casino = db.collection('casinos').doc(casinoId);
  const existing = (await casino.collection('users').doc(user.uid).get()).data() || {};
  const creditRole = creditArg === undefined ? (existing.creditRole ?? null) : creditArg === 'none' ? null : creditArg;
  const profile = {
    id: user.uid,
    name: name || existing.name || user.displayName || email,
    role,
    creditRole,
    email,
    updatedBy: 'admin-script',
    updatedAt: new Date().toISOString(),
  };
  const batch = db.batch();
  batch.set(casino.collection('users').doc(user.uid), profile, { merge: true });
  batch.delete(casino.collection('access_requests').doc(user.uid)); // no longer waiting, if they had registered
  await batch.commit();

  const before = existing.role ? ` (was ${existing.role}${existing.creditRole ? ` · ${existing.creditRole}` : ''})` : '';
  console.log(`✓ ${created ? 'Created' : 'Updated'} ${email} (uid ${user.uid})${created ? '' : before}`);
  console.log(`  role: ${role}${creditRole ? ` · credit role: ${creditRole}` : ''}`);
  if (resetLink && created) {
    const link = await auth.generatePasswordResetLink(email);
    console.log('  Send this link to the person so they can choose a password (it expires):');
    console.log(`  ${link}`);
  } else if (created) {
    console.log('  They can sign in now with this email and password.');
  }
}

main().then(() => process.exit(0)).catch((e) => {
  console.error(`✗ ${e.message}`);
  if (/default credentials|Could not load the default credentials/i.test(e.message)) {
    console.error('  Run: gcloud auth application-default login   (or pass --service-account <key.json>)');
  }
  process.exit(1);
});
