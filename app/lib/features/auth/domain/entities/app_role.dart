/// What a signed-in operator may do. Checked in the UI; enforced again by
/// Firestore rules and Cloud Functions on the Firebase backend.
enum Perm {
  viewAll,
  ratePlayers,
  managePlayers,
  tableAccounting,
  creditApply,
  creditAssess,
  creditApprove,
  markers,
  cashTransactions,
  complianceReview,
  evaluateDeals,
  staffing,
  settings,
  manageUsers,
}

enum AppRole {
  admin('admin', 'Admin', {...Perm.values}),
  casinoManager('casino_manager', 'Casino Manager', {
    Perm.viewAll, Perm.ratePlayers, Perm.managePlayers, Perm.tableAccounting, Perm.creditApply, Perm.creditAssess,
    Perm.creditApprove, Perm.markers, Perm.complianceReview, Perm.evaluateDeals, Perm.staffing,
  }),
  pitSupervisor('pit_supervisor', 'Pit Supervisor', {
    Perm.viewAll, Perm.ratePlayers, Perm.managePlayers, Perm.tableAccounting, Perm.markers, Perm.cashTransactions,
  }),
  cageCashier('cage_cashier', 'Cage Cashier', {Perm.viewAll, Perm.managePlayers, Perm.markers, Perm.cashTransactions, Perm.creditApply}),
  creditExecutive('credit_executive', 'Credit Executive', {
    Perm.viewAll, Perm.managePlayers, Perm.creditApply, Perm.creditAssess, Perm.creditApprove, Perm.markers,
  }),
  complianceOfficer('compliance_officer', 'Compliance Officer', {Perm.viewAll, Perm.cashTransactions, Perm.complianceReview}),
  marketing('marketing', 'Marketing / Host', {
    Perm.viewAll, Perm.managePlayers, Perm.ratePlayers, Perm.creditApply, Perm.evaluateDeals, Perm.creditApprove,
  }),
  auditor('auditor', 'Auditor (read-only)', {Perm.viewAll});

  const AppRole(this.wire, this.label, this.perms);

  final String wire;
  final String label;
  final Set<Perm> perms;

  /// Unknown values from the server fall back to the least-privileged role.
  static AppRole fromWire(String? w) => values.firstWhere((r) => r.wire == w, orElse: () => auditor);
}
