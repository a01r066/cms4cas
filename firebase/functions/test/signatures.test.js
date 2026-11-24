// Run: npm test   (no Firebase needed — SDK modules are stubbed)
const test = require('node:test');
const assert = require('node:assert');
const Module = require('module');

const realLoad = Module._load;
Module._load = function (req, ...rest) {
  if (req === 'firebase-functions/v2/https') return { onCall: (f) => f, HttpsError: class extends Error {} };
  if (req === 'firebase-admin') return { initializeApp() {}, firestore: () => ({}) };
  return realLoad.call(this, req, ...rest);
};
const { checkSignatures, balanceOf } = require('../src/index.js')._internal;

// Same cases as packages/casino_engine/test/rules_test.dart (Table 6.2, p.103).
test('permanent ≤ $50k: CM or VP Finance + one other executive', () => {
  assert.equal(checkSignatures('permanent', 40000, ['credit_manager']).ok, false);
  assert.equal(checkSignatures('permanent', 40000, ['host', 'shift_manager']).ok, false);
  assert.equal(checkSignatures('permanent', 40000, ['credit_manager', 'host']).ok, true);
});

test('permanent ≤ $100k: three signatures incl. two committee members', () => {
  assert.equal(checkSignatures('permanent', 80000, ['credit_manager', 'host', 'shift_manager']).ok, false);
  assert.equal(checkSignatures('permanent', 80000, ['credit_manager', 'president', 'host']).ok, true);
});

test('permanent > $100k: full committee', () => {
  assert.equal(checkSignatures('permanent', 150000, ['credit_manager', 'president', 'vp_finance']).ok, false);
  assert.equal(checkSignatures('permanent', 150000, ['credit_manager', 'president', 'vp_finance', 'casino_manager']).ok, true);
});

test('temporary tiers and cage director is not an executive', () => {
  assert.equal(checkSignatures('temporary', 10000, ['cage_director']).ok, false);
  assert.equal(checkSignatures('temporary', 10000, ['host']).ok, true);
  assert.equal(checkSignatures('temporary', 20000, ['host', 'host']).ok, false); // duplicate counts once
  assert.equal(checkSignatures('temporary', 20000, ['host', 'shift_manager']).ok, true);
  assert.equal(checkSignatures('temporary', 40000, ['host', 'shift_manager', 'president']).ok, false);
  assert.equal(checkSignatures('temporary', 40000, ['credit_manager', 'host', 'shift_manager']).ok, true);
  assert.equal(checkSignatures('temporary', 60000, ['credit_manager', 'host', 'shift_manager', 'president']).ok, false);
});

test('marker balance', () => {
  assert.equal(balanceOf({ amount: 5000, payments: [{ amount: 2000 }], status: 'open' }), 3000);
  assert.equal(balanceOf({ amount: 5000, payments: [], status: 'written_off' }), 0);
});
