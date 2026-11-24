import 'package:casino_engine/casino_engine.dart';

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

  final String wire;
  final String label;
  final Set<Perm> perms;
  const AppRole(this.wire, this.label, this.perms);

  static AppRole fromWire(String? w) => values.firstWhere((r) => r.wire == w, orElse: () => auditor);
}

class AppUser {
  final String id;
  final String name;
  final AppRole role;
  final CreditRole? creditRole; // signing authority under Table 6.2
  final String? email;
  const AppUser({required this.id, required this.name, required this.role, this.creditRole, this.email});

  bool can(Perm p) => role.perms.contains(p);
  bool get canSignCredit => creditRole != null && can(Perm.creditApprove);

  Map<String, dynamic> toJson() => {'name': name, 'role': role.wire, 'creditRole': creditRole?.wire, 'email': email};
  factory AppUser.fromJson(Map<String, dynamic> j) => AppUser(
        id: j['id'] as String,
        name: (j['name'] ?? '') as String,
        role: AppRole.fromWire(j['role'] as String?),
        creditRole: CreditRole.fromWire(j['creditRole'] as String?),
        email: j['email'] as String?,
      );
}
