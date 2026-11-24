#!/usr/bin/env node
// Load (or remove) the CMS demo data set in the DEV Firebase project, plus email/password
// logins for the demo staff (uid = demo-*, email demo.<role>@cms4cas.test, one shared password).
// Refuses the production project.
//
//   bash app/tool/seed_demo_data.sh                    # regenerate the JSON, then load
//   bash app/tool/seed_demo_data.sh --remove           # delete demo docs and demo logins
//
//   node scripts/seed-demo-data.js --project dev [--file ../seed/demo_data.json] [--casino main]
//        [--password <pw>] [--no-logins] [--remove] [--service-account key.json]
//
// Emulators: set FIREBASE_AUTH_EMULATOR_HOST and FIRESTORE_EMULATOR_HOST; no credentials needed.
'use strict';

const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { initializeApp, applicationDefault, cert } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore } = require('firebase-admin/firestore');

const MIN_PASSWORD = 8;
const BATCH = 450;
const PREFIX = 'demo-';
const ISO_LOCAL = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?$/; // Dart toIso8601String() of local time

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

function aliases() {
  const rc = path.join(__dirname, '..', '..', '.firebaserc');
  return fs.existsSync(rc) ? (JSON.parse(fs.readFileSync(rc, 'utf8')).projects || {}) : {};
}

/** Only the dev project (or an emulator) — never production. */
function resolveDevProject(p, usingEmulators) {
  if (!p || p === true) throw new Error('--project is required (dev, or the dev project id).');
  const a = aliases();
  const id = a[p] || p;
  if (p === 'prod' || (a.prod && id === a.prod)) throw new Error('Refusing to seed demo data into the production project.');
  if (!usingEmulators && a.dev && id !== a.dev) {
    throw new Error(`Demo data only goes into the dev project (${a.dev}); got "${id}".`);
  }
  if (!usingEmulators && !a.dev) throw new Error('No "dev" alias in app/firebase/.firebaserc. Run app/tool/firebase_setup.sh first.');
  return id;
}

function askHidden(question) {
  return new Promise((resolve, reject) => {
    if (!process.stdin.isTTY) return reject(new Error('No terminal for a password prompt: pass --password or --no-logins.'));
    const rl = readline.createInterface({ input: process.stdin, output: process.stdout, terminal: true });
    rl._writeToOutput = (s) => { if (s.startsWith(question)) rl.output.write(s); };
    rl.question(question, (answer) => { rl.close(); process.stdout.write('\n'); resolve(answer); });
  });
}

const pad = (n, w = 2) => String(n).padStart(w, '0');
function toLocalIso(d) {
  return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}T${pad(d.getHours())}:${pad(d.getMinutes())}:${pad(d.getSeconds())}.${pad(d.getMilliseconds(), 3)}`;
}

/** Moves every date by whole days so "today" in the file is today; never into the future. */
function shiftDates(value, days, now) {
  if (Array.isArray(value)) return value.map((v) => shiftDates(v, days, now));
  if (value && typeof value === 'object') {
    return Object.fromEntries(Object.entries(value).map(([k, v]) => [k, shiftDates(v, days, now)]));
  }
  if (typeof value === 'string' && ISO_LOCAL.test(value) && days !== 0) {
    const d = new Date(value);
    d.setDate(d.getDate() + days);
    return toLocalIso(d > now ? new Date(now.getTime() - 60000) : d);
  }
  return value;
}

async function commitInBatches(db, ops) {
  for (let i = 0; i < ops.length; i += BATCH) {
    const b = db.batch();
    for (const op of ops.slice(i, i + BATCH)) op(b);
    await b.commit();
  }
}

async function main() {
  const args = parseArgs(process.argv.slice(2));
  const usingEmulators = !!(process.env.FIREBASE_AUTH_EMULATOR_HOST && process.env.FIRESTORE_EMULATOR_HOST);
  const projectId = resolveDevProject(args.project, usingEmulators);
  const casinoId = typeof args.casino === 'string' ? args.casino : 'main';
  const file = path.resolve(typeof args.file === 'string' ? args.file : path.join(__dirname, '..', '..', 'seed', 'demo_data.json'));
  const remove = args.remove === true;
  const logins = args['no-logins'] !== true;

  const options = { projectId };
  if (!usingEmulators) {
    options.credential = typeof args['service-account'] === 'string'
      ? cert(JSON.parse(fs.readFileSync(args['service-account'], 'utf8')))
      : applicationDefault();
  }
  initializeApp(options);
  const auth = getAuth();
  const db = getFirestore();
  const casino = db.collection('casinos').doc(casinoId);
  console.log(`▸ ${usingEmulators ? 'EMULATORS' : 'Firebase project'} ${projectId} · casino "${casinoId}"`);

  if (remove) {
    let n = 0;
    const cols = await casino.listCollections();
    const ops = [];
    for (const col of cols) {
      const snap = await col.get();
      for (const doc of snap.docs) {
        if (doc.id.startsWith(PREFIX)) { ops.push((b) => b.delete(doc.ref)); n++; }
      }
    }
    await commitInBatches(db, ops);
    let u = 0;
    let page;
    do {
      page = await auth.listUsers(1000, page && page.pageToken);
      const ids = page.users.filter((x) => x.uid.startsWith(PREFIX)).map((x) => x.uid);
      if (ids.length) { await auth.deleteUsers(ids); u += ids.length; }
    } while (page.pageToken);
    console.log(`✓ Removed ${n} demo documents and ${u} demo logins.`);
    return;
  }

  if (!fs.existsSync(file)) throw new Error(`${file} not found. Run: (cd app && dart run tool/export_demo_data.dart)`);
  const seed = JSON.parse(fs.readFileSync(file, 'utf8'));
  const now = new Date();
  const generated = new Date(seed.generatedAt);
  const dayMs = 86400000;
  const midnight = (d) => new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
  const days = Math.round((midnight(now) - midnight(generated)) / dayMs);
  if (days !== 0) console.log(`  The file is ${days} day(s) old: moving its dates forward.`);

  const ops = [];
  let n = 0;
  for (const [col, docs] of Object.entries(seed.collections)) {
    for (const [id, data] of Object.entries(docs)) {
      if (!id.startsWith(PREFIX)) throw new Error(`Refusing non-demo id ${col}/${id}.`);
      const doc = shiftDates(data, days, now);
      ops.push((b) => b.set(casino.collection(col).doc(id), doc));
      n++;
    }
  }
  await commitInBatches(db, ops);
  console.log(`✓ Wrote ${n} demo documents.`);

  if (!logins) return;
  const password = typeof args.password === 'string' ? args.password : await askHidden('Password for all demo logins: ');
  if (password.length < MIN_PASSWORD) throw new Error(`Use at least ${MIN_PASSWORD} characters for the password.`);
  for (const l of seed.logins) {
    const props = { email: l.email, displayName: l.name, password, emailVerified: true, disabled: false };
    try {
      await auth.updateUser(l.uid, props);
    } catch (e) {
      if (e.code !== 'auth/user-not-found') throw e;
      await auth.createUser({ uid: l.uid, ...props });
    }
    console.log(`  ${l.email.padEnd(32)} ${l.name}`);
  }
  console.log(`✓ ${seed.logins.length} demo logins ready (same password for all).`);
}

main().catch((e) => { console.error(`✗ ${e.message}`); process.exit(1); });
