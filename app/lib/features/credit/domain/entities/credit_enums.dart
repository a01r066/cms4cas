enum CreditStatus {
  draft('draft', 'Draft'),
  pendingApproval('pending_approval', 'Awaiting signatures'),
  approved('approved', 'Approved'),
  declined('declined', 'Declined');

  const CreditStatus(this.wire, this.label);
  final String wire, label;

  static CreditStatus fromWire(String? w) => values.firstWhere((s) => s.wire == w, orElse: () => draft);
}

enum MarkerStatus {
  open('open', 'Open'),
  paid('paid', 'Paid'),
  settled('settled', 'Settled'),
  writtenOff('written_off', 'Written off');

  const MarkerStatus(this.wire, this.label);
  final String wire, label;

  static MarkerStatus fromWire(String? w) => values.firstWhere((s) => s.wire == w, orElse: () => open);
}
