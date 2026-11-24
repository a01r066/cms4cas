// CMS privileged actions. The client never writes roles, credit decisions,
// marker money movements or CTR sign-offs directly: Firestore rules deny those
// writes and these callables apply the book's controls server-side.
//
// Each action has a Dart twin for the local backend (app/lib/features/*/data/
// datasources/*_local_actions.dart). Keep the checks and messages in step.
// Dates are stored as ISO-8601 strings, like the app writes them.
const { onCall, HttpsError } = require('firebase-functions/v2/https');
const { setGlobalOptions } = require('firebase-functions/v2');
const { initializeApp } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore } = require('firebase-admin/firestore');

initializeApp();
const db = getFirestore();

// Close to Vietnam; must match F.functionsRegion in app/lib/flavors.dart.
setGlobalOptions({ region: 'asia-southeast1' });

const { ROLES, CREDIT_ROLES } = require('./roles');
const CREDIT_APPROVER_ROLES = ['admin', 'casino_manager', 'credit_executive', 'marketing'];
const MARKER_ROLES = ['admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'credit_executive'];
const CTR_PREPARE_ROLES = ['admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'compliance_officer'];
const CTR_REVIEW_ROLES = ['admin', 'casino_manager', 'compliance_officer'];
const WRITE_OFF_SIGNERS = ['president', 'vp_finance', 'credit_manager', 'cage_director'];
// Patron-identification fields that must be complete before a CTR is prepared (first 8 of Aml.ctrRequiredFields).
const CTR_REQUIRED = [
  'Date and time of transaction', 'Amount', 'Transaction type', "Patron's name", "Patron's permanent address",
  'ID method, document type and number', 'Social Security number (or national ID)', 'Date of birth and casino account number',
];

const now = () => new Date().toISOString();
const fail = (code, msg) => { throw new HttpsError(code, msg); };
const col = (cid, c) => db.collection('casinos').doc(cid).collection(c);

function str(data, key, required = true) {
  const v = data[key];
  if (typeof v === 'string' && v.trim()) return v.trim();
  if (required) fail('invalid-argument', `Missing ${key}.`);
  return '';
}
function num(data, key) {
  const v = data[key];
  if (typeof v === 'number' && Number.isFinite(v)) return v;
  fail('invalid-argument', `Missing or invalid ${key}.`);
}

/** Caller's profile in casinos/{cid}/users/{uid}, optionally restricted to roles. */
async function member(req, roles) {
  if (!req.auth) fail('unauthenticated', 'Sign in first.');
  const cid = str(req.data || {}, 'casinoId');
  const snap = await col(cid, 'users').doc(req.auth.uid).get();
  if (!snap.exists) fail('permission-denied', 'Your account has no CMS role.');
  const me = snap.data();
  if (roles && !roles.includes(me.role)) fail('permission-denied', 'Your role cannot perform this action.');
  return { cid, uid: req.auth.uid, me };
}

// ---- Table 6.2 (p.103): signature requirements. Port of Credit.checkSignatures. ----
const COMMITTEE = ['president', 'vp_finance', 'casino_manager', 'credit_manager'];
const EXECUTIVE = ['president', 'vp_finance', 'casino_manager', 'credit_manager', 'shift_manager', 'host'];
const LABEL = { president: 'President / GM', vp_finance: 'VP Finance', casino_manager: 'Casino Manager', credit_manager: 'Credit Manager' };

function checkSignatures(lineType, amount, roles) {
  const s = new Set(roles);
  const execs = [...s].filter((r) => EXECUTIVE.includes(r)).length;
  const committee = [...s].filter((r) => COMMITTEE.includes(r)).length;
  const cmOrVpf = s.has('credit_manager') || s.has('vp_finance');
  if (lineType === 'permanent') {
    if (amount <= 50000) {
      if (!cmOrVpf) return { ok: false, missing: 'Credit Manager or VP Finance' };
      if (execs < 2) return { ok: false, missing: 'one more credit executive' };
      return { ok: true };
    }
    if (amount <= 100000) {
      if (!cmOrVpf) return { ok: false, missing: 'Credit Manager or VP Finance' };
      if (committee < 2) return { ok: false, missing: 'a second credit committee member' };
      if (execs < 3) return { ok: false, missing: 'one more credit executive' };
      return { ok: true };
    }
    const missing = COMMITTEE.filter((r) => !s.has(r)).map((r) => LABEL[r]);
    return missing.length ? { ok: false, missing: missing.join(', ') } : { ok: true };
  }
  if (amount <= 10000) return execs ? { ok: true } : { ok: false, missing: 'a credit executive' };
  if (amount <= 25000) return execs >= 2 ? { ok: true } : { ok: false, missing: `${2 - execs} more credit executive(s)` };
  if (amount <= 50000) {
    if (!s.has('credit_manager')) return { ok: false, missing: 'Credit Manager' };
    return execs >= 3 ? { ok: true } : { ok: false, missing: `${3 - execs} more credit executive(s)` };
  }
  return { ok: false, missing: 'permanent-line approval' };
}

const paidOf = (m) => (m.payments || []).reduce((a, p) => a + (p.amount || 0), 0);
const balanceOf = (m) => ((m.status || 'open') === 'open' ? Math.max(0, (m.amount || 0) - paidOf(m)) : 0);

/** Port of availableCredit: larger of latest approved permanent / temporary line, minus open balances. */
async function availableCredit(cid, playerId) {
  const apps = (await col(cid, 'credit_applications').where('playerId', '==', playerId).where('status', '==', 'approved').get()).docs.map((d) => d.data());
  const latest = (t) => {
    const l = apps.filter((a) => (a.lineType || 'permanent') === t)
      .sort((a, b) => String(b.decidedAt || b.createdAt).localeCompare(String(a.decidedAt || a.createdAt)));
    return l.length ? l[0].amount || 0 : 0;
  };
  const line = Math.max(latest('permanent'), latest('temporary'));
  const markers = (await col(cid, 'markers').where('playerId', '==', playerId).get()).docs.map((d) => d.data());
  const outstanding = markers.reduce((a, m) => a + balanceOf(m), 0);
  return { line, outstanding, available: Math.max(0, line - outstanding) };
}

// ---------------------------------------------------------------- users
exports.setUserRole = onCall(async (req) => {
  if (!req.auth) fail('unauthenticated', 'Sign in first.');
  const data = req.data || {};
  const cid = str(data, 'casinoId');
  const name = str(data, 'name');
  const role = str(data, 'role');
  const creditRole = data.creditRole ?? null;
  const email = data.email ?? null;
  let uid = data.uid || null;
  if (!ROLES.includes(role)) fail('invalid-argument', 'Unknown role.');
  if (creditRole !== null && !CREDIT_ROLES.includes(creditRole)) fail('invalid-argument', 'Unknown credit role.');
  if (!uid && email) {
    try { uid = (await getAuth().getUserByEmail(email)).uid; } catch (e) { fail('not-found', `No Firebase account for ${email}. Create it in Authentication first.`); }
  }
  if (!uid) fail('invalid-argument', 'Give the user\'s sign-in email.');
  const users = col(cid, 'users');
  const anyUsers = !(await users.limit(1).get()).empty;
  if (!anyUsers) {
    // Bootstrap: the very first user of a casino may only make themself admin.
    if (uid !== req.auth.uid || role !== 'admin') fail('failed-precondition', 'The first user must be an administrator.');
  } else {
    const caller = await users.doc(req.auth.uid).get();
    if (!caller.exists || caller.data().role !== 'admin') fail('permission-denied', 'Only an administrator can assign roles.');
  }
  const batch = db.batch();
  batch.set(users.doc(uid), { id: uid, name, role, creditRole, email, updatedBy: req.auth.uid, updatedAt: now() }, { merge: true });
  // A registrant who now has a role is no longer waiting.
  batch.delete(col(cid, 'access_requests').doc(uid));
  await batch.commit();
  return { ok: true, uid };
});

// ---------------------------------------------------------------- credit (Ch6)
exports.signCreditApplication = onCall(async (req) => {
  const { cid, uid, me } = await member(req, CREDIT_APPROVER_ROLES);
  if (!CREDIT_ROLES.includes(me.creditRole)) fail('permission-denied', 'You have no credit signing role.');
  const ref = col(cid, 'credit_applications').doc(str(req.data, 'appId'));
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    if (!snap.exists) fail('not-found', 'Credit application not found.');
    const a = snap.data();
    if (a.status !== 'pending_approval') fail('failed-precondition', 'The application is not awaiting signatures.');
    const sigs = a.signatures || [];
    if (sigs.some((s) => s.userId === uid)) fail('already-exists', 'You have already signed.');
    tx.update(ref, { signatures: [...sigs, { userId: uid, userName: me.name || '', role: me.creditRole, at: now() }] });
  });
  return { ok: true };
});

exports.decideCreditApplication = onCall(async (req) => {
  const { cid } = await member(req, CREDIT_APPROVER_ROLES);
  const decision = str(req.data, 'decision');
  const ref = col(cid, 'credit_applications').doc(str(req.data, 'appId'));
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    if (!snap.exists) fail('not-found', 'Credit application not found.');
    const a = snap.data();
    if (decision === 'decline') {
      const reason = str(req.data, 'reason');
      if (!['draft', 'pending_approval'].includes(a.status)) fail('failed-precondition', 'Already decided.');
      tx.update(ref, { status: 'declined', declineReason: reason, decidedAt: now() });
      return;
    }
    if (decision !== 'approve') fail('invalid-argument', 'Unknown decision.');
    if (a.status !== 'pending_approval') fail('failed-precondition', 'The application is not awaiting signatures.');
    if (!a.outcome || ['doNotIssue', 'incomplete'].includes(a.outcome)) fail('failed-precondition', 'The assessment does not allow approval.');
    const roles = (a.signatures || []).map((s) => s.role);
    const check = checkSignatures(a.lineType || 'permanent', a.amount || 0, roles);
    if (!check.ok) fail('failed-precondition', `Still needed: ${check.missing}`);
    if (a.outcome === 'referToCreditManager' && !roles.includes('credit_manager')) {
      fail('failed-precondition', 'A Credit Manager signature is required for a referred application.');
    }
    tx.update(ref, { status: 'approved', decidedAt: now() });
  });
  return { ok: true };
});

exports.issueMarker = onCall(async (req) => {
  const { cid, me } = await member(req, MARKER_ROLES);
  const playerId = str(req.data, 'playerId');
  const number = str(req.data, 'number');
  const table = str(req.data, 'table');
  const amount = num(req.data, 'amount');
  if (amount <= 0) fail('invalid-argument', 'Enter an amount.');
  const line = await availableCredit(cid, playerId);
  if (line.line <= 0) fail('failed-precondition', 'The player has no approved credit line.');
  if (amount > line.available + 0.001) fail('failed-precondition', 'Exceeds available credit.');
  const ref = col(cid, 'markers').doc();
  await ref.set({
    id: ref.id, playerId, number, table, issuedBy: me.name || '', amount, issuedAt: now(),
    payments: [], status: 'open', writeOffAmount: 0, writeOffReason: '', writeOffSignatures: [], collectionNote: '',
  });
  return { markerId: ref.id };
});

async function updateMarker(req, roles, fn) {
  const ctx = await member(req, roles);
  const ref = col(ctx.cid, 'markers').doc(str(req.data, 'markerId'));
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    if (!snap.exists) fail('not-found', 'Marker not found.');
    tx.update(ref, fn(snap.data(), ctx));
  });
  return { ok: true };
}

exports.recordMarkerPayment = onCall((req) => updateMarker(req, MARKER_ROLES, (m, { me }) => {
  const amount = num(req.data, 'amount');
  const method = str(req.data, 'method');
  if ((m.status || 'open') !== 'open') fail('failed-precondition', 'The marker is not open.');
  if (amount <= 0 || amount > balanceOf(m) + 0.001) fail('invalid-argument', 'Enter an amount between $0 and the balance.');
  const payments = [...(m.payments || []), { amount, method, recordedBy: me.name || '', at: now() }];
  const paidAll = payments.reduce((a, p) => a + p.amount, 0) >= (m.amount || 0) - 0.001;
  return { payments, status: paidAll ? 'paid' : 'open' };
}));

exports.signMarkerWriteOff = onCall((req) => updateMarker(req, [...new Set([...MARKER_ROLES, ...CREDIT_APPROVER_ROLES])], (m, { uid, me }) => {
  if (!WRITE_OFF_SIGNERS.includes(me.creditRole)) {
    fail('permission-denied', 'Write-offs are signed by the President/GM, VP Finance, Credit Manager or Director of Cage.');
  }
  if ((m.status || 'open') !== 'open') fail('failed-precondition', 'The marker is not open.');
  const sigs = m.writeOffSignatures || [];
  if (sigs.some((s) => s.userId === uid)) fail('already-exists', 'You have already signed.');
  return {
    writeOffSignatures: [...sigs, { userId: uid, userName: me.name || '', role: me.creditRole, at: now() }],
    writeOffReason: str(req.data, 'reason', false),
  };
}));

exports.writeOffMarker = onCall((req) => updateMarker(req, [...new Set([...MARKER_ROLES, ...CREDIT_APPROVER_ROLES])], (m) => {
  const reason = str(req.data, 'reason');
  const balance = balanceOf(m);
  if ((m.status || 'open') !== 'open' || balance <= 0) fail('failed-precondition', 'Nothing to write off.');
  // p.105: two of President/GM, VP Finance, Credit Manager, Director of Cage.
  const signers = new Set((m.writeOffSignatures || []).map((s) => s.role).filter((r) => WRITE_OFF_SIGNERS.includes(r)));
  if (signers.size < 2) fail('failed-precondition', 'Two authorized signatures are required before writing off.');
  return { status: paidOf(m) > 0 ? 'settled' : 'written_off', writeOffAmount: balance, writeOffReason: reason };
}));

// ---------------------------------------------------------------- currency compliance (Ch5)
exports.advanceCtr = onCall(async (req) => {
  const to = str(req.data || {}, 'to');
  const { cid, uid, me } = await member(req, to === 'prepared' ? CTR_PREPARE_ROLES : CTR_REVIEW_ROLES);
  const ref = col(cid, 'ctr_reports').doc(str(req.data, 'ctrId'));
  await db.runTransaction(async (tx) => {
    const snap = await tx.get(ref);
    if (!snap.exists) fail('not-found', 'Report not found.');
    const r = snap.data();
    const status = r.status || 'draft';
    if (to === 'prepared') {
      if (status !== 'draft') fail('failed-precondition', 'Only a draft can be prepared.');
      if (!CTR_REQUIRED.every((f) => (r.fields || {})[f] === true)) fail('failed-precondition', 'Complete the required fields first.');
      tx.update(ref, { status: 'prepared', preparedBy: me.name || '', preparedById: uid });
    } else if (to === 'reviewed') {
      if (status !== 'prepared') fail('failed-precondition', 'The report has not been prepared.');
      if (r.preparedById === uid) fail('failed-precondition', 'The reviewer must be a different employee from the preparer.');
      tx.update(ref, { status: 'reviewed', reviewedBy: me.name || '', reviewedById: uid });
    } else if (to === 'filed') {
      if (status !== 'reviewed') fail('failed-precondition', 'The report has not been reviewed.');
      tx.update(ref, { status: 'filed', filedAt: now() });
    } else {
      fail('invalid-argument', 'A report cannot go back to draft.');
    }
  });
  return { ok: true };
});

// Exported for unit tests.
exports._internal = { checkSignatures, balanceOf };
