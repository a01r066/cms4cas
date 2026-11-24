import 'book_ref.dart';

/// A progressive tax tier: [upTo] is the band width (null = no cap).
class TaxTier {
  final double? width;
  final double rate;
  const TaxTier(this.width, this.rate);
}

/// Ch3 gaming taxes.
class GamingTax {
  static const ref = BookRef(3, '36–39', 'Gaming taxes (Nevada / Atlantic City, 2003)');

  /// Nevada tiers as printed (p.36): 3.5% first $50k, 4.5% next $84k, 6.75% above.
  static const nevada2003 = [TaxTier(50000, 0.035), TaxTier(84000, 0.045), TaxTier(null, 0.0675)];

  /// Cash-basis taxable win: win − credit issued & still outstanding + prior credit collected (p.36).
  static double cashBasisTaxableWin({
    required double grossWin,
    required double creditIssuedOutstanding,
    required double priorCreditCollected,
  }) =>
      grossWin - creditIssuedOutstanding + priorCreditCollected;

  static double tieredTax(double taxable, List<TaxTier> tiers) {
    var remaining = taxable < 0 ? 0.0 : taxable;
    var tax = 0.0;
    for (final t in tiers) {
      final band = t.width == null ? remaining : (remaining < t.width! ? remaining : t.width!);
      tax += band * t.rate;
      remaining -= band;
      if (remaining <= 0) break;
    }
    return tax;
  }

  /// Atlantic City: 8% × (gross − min(4% gross, bad-debt provision)) (p.39).
  static double atlanticCity({required double grossWin, required double badDebtProvision}) {
    final cap = 0.04 * grossWin;
    return 0.08 * (grossWin - (badDebtProvision < cap ? badDebtProvision : cap));
  }

  /// Conditions under which NV may tax unpaid credit (p.39). Returns the failed conditions.
  static List<String> unpaidCreditTaxRisks({
    required bool signatureObtained,
    required bool addressObtained,
    required bool collectionEffortDocumented,
    required bool creditHistoryChecked,
    required bool balanceConfirmable,
  }) =>
      [
        if (!signatureObtained) 'No player signature / written acknowledgment of the debt',
        if (!addressObtained) "No player address on file",
        if (!collectionEffortDocumented) 'No evidence of reasonable collection effort',
        if (!creditHistoryChecked) 'Credit history not checked before extending credit',
        if (!balanceConfirmable) 'Player asked that the balance not be confirmed at audit',
      ];
}
