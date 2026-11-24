// Role names shared by the Cloud Functions and the admin scripts.
// Must match AppRole / CreditRole wire values in the app (lib/features/auth/domain/entities/app_role.dart,
// packages/casino_engine/lib/src/credit.dart).
const ROLES = ['admin', 'casino_manager', 'pit_supervisor', 'cage_cashier', 'credit_executive', 'compliance_officer', 'marketing', 'auditor'];
const CREDIT_ROLES = ['president', 'vp_finance', 'casino_manager', 'credit_manager', 'shift_manager', 'host', 'cage_director'];

module.exports = { ROLES, CREDIT_ROLES };
