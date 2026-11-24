// Privileged writes: user roles. Only an admin of the casino may assign roles.
const { onCall, HttpsError } = require('firebase-functions/v2/https');
const admin = require('firebase-admin');
admin.initializeApp();

const ROLES = ['admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'credit_executive', 'compliance_officer', 'marketing', 'auditor'];
const CREDIT_ROLES = ['president', 'vp_finance', 'casino_manager', 'credit_manager', 'shift_manager', 'host', 'cage_director', null];

exports.setUserRole = onCall(async (req) => {
  const { casinoId, name, role, creditRole = null, email = null } = req.data || {};
  let { uid } = req.data || {};
  if (!req.auth) throw new HttpsError('unauthenticated', 'Sign in first.');
  if (!uid && email) {
    try { uid = (await admin.auth().getUserByEmail(email)).uid; }
    catch (e) { throw new HttpsError('not-found', `No Firebase account for ${email}. Create it in Authentication first.`); }
  }
  if (!casinoId || !uid || !name || !ROLES.includes(role) || !CREDIT_ROLES.includes(creditRole)) {
    throw new HttpsError('invalid-argument', 'casinoId, uid, name and a valid role are required.');
  }
  const users = admin.firestore().collection('casinos').doc(casinoId).collection('users');
  const caller = await users.doc(req.auth.uid).get();
  const anyUsers = !(await users.limit(1).get()).empty;
  // Bootstrap: the very first user of a casino may make themselves admin.
  const bootstrap = !anyUsers && uid === req.auth.uid && role === 'admin';
  if (!bootstrap && (!caller.exists || caller.data().role !== 'admin')) {
    throw new HttpsError('permission-denied', 'Only an administrator can assign roles.');
  }
  await users.doc(uid).set({ name, role, creditRole, email, updatedBy: req.auth.uid, updatedAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
  return { ok: true, uid };
});
