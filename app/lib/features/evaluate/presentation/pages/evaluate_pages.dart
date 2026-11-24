import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/util/fmt.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../settings/presentation/providers/settings_providers.dart';

/// Promotion & deal evaluator (Ch14–16) and comp schedules (Ch15).
class EvaluatePage extends StatelessWidget {
  const EvaluatePage({super.key});
  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: TabBar(isScrollable: true, tabs: [
            Tab(text: 'Match play'), Tab(text: 'Package program'), Tab(text: 'Rebate on loss'), Tab(text: 'Premium deal'), Tab(text: 'Dead chips'), Tab(text: 'Comp schedule'),
          ]),
          body: TabBarView(children: [_MatchPlay(), _Program(), _Rebate(), _Premium(), _DeadChips(), _CompSchedule()]),
        ),
      );
}

/// Base for calculator tabs: controllers that recompute on change.
abstract class _CalcState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  final Map<String, TextEditingController> f = {};
  TextEditingController c(String k, String init) => f.putIfAbsent(k, () => TextEditingController(text: init));
  double v(String k) => parseNum(f[k]?.text) ?? 0;
  Widget nf(String k, String label, String init, {String? suffix, String? prefix, String? helper, double? min = 0, double? max}) => NumField(
        label: label, controller: c(k, init), suffix: suffix, prefix: prefix, helper: helper, min: min, max: max, onChanged: (_) => setState(() {}));
}

class _MatchPlay extends ConsumerStatefulWidget {
  const _MatchPlay();
  @override
  ConsumerState<_MatchPlay> createState() => _MatchPlayState();
}

class _MatchPlayState extends _CalcState<_MatchPlay> {
  bool withExchange = true;
  bool nonnegotiable = false;
  @override
  Widget build(BuildContext context) {
    final tax = ref.watch(settingsProvider).gamingTaxRate;
    final w = [nf('face', 'Coupon face value', '5', prefix: '\$ '), if (!nonnegotiable) nf('cash', 'Required cash match', '5', prefix: '\$ '),
      nf('ha', 'House advantage of the bet', '1.5', suffix: '%', min: 0.01), nf('bet', 'Typical average bet afterwards', '5', prefix: '\$ ', min: 0.01),
      nf('hph', 'Hands per hour', '50', min: 1), nf('count', 'Coupons redeemed per month', '1000')];
    final ha = v('ha') / 100;
    final r = Promotions.matchPlayCost(face: v('face'), cashMatch: nonnegotiable ? 0 : v('cash'), houseAdvantage: ha, withExchange: withExchange, tax: tax);
    final recover = ha > 0 ? Promotions.wagersToRecover(r.netCost, ha, tax: tax) : 0.0;
    final hands = v('bet') > 0 ? recover / v('bet') : 0.0;
    final hours = v('hph') > 0 ? hands / v('hph') : 0.0;
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: 'Coupon', children: [
        Wrap(spacing: 12, children: [
          SegmentedButton<bool>(segments: const [ButtonSegment(value: false, label: Text('Match play')), ButtonSegment(value: true, label: Text('Nonnegotiable chip'))],
              selected: {nonnegotiable}, onSelectionChanged: (s) => setState(() => nonnegotiable = s.first)),
          SegmentedButton<bool>(segments: const [ButtonSegment(value: true, label: Text('With exchange')), ButtonSegment(value: false, label: Text('Without exchange'))],
              selected: {withExchange}, onSelectionChanged: (s) => setState(() => withExchange = s.first)),
        ]),
        const SizedBox(height: 12),
        Text(withExchange ? 'With exchange: the coupon is taken on a win or a loss.' : 'Without exchange: the coupon is lost only when the bet loses, so it is bet ~1.97 times on average.'),
        const SizedBox(height: 12),
        FieldGrid(children: w),
      ]),
      SectionCard(title: 'Cost to the casino', children: [
        MetricGrid([
          Metric('Coupon cost', money(r.couponCost)),
          Metric('Casino gain on cash match', money(r.cashGain), note: 'after ${pct(tax, 2)} gaming tax'),
          Metric('Net cost per coupon', money(r.netCost)),
          Metric('Monthly cost', money0(r.netCost * v('count'))),
          Metric('Wagers to recover', money(recover)),
          Metric('Play to recover', '${hands.toStringAsFixed(1)} hands · ${(hours * 60).toStringAsFixed(0)} min'),
        ]),
        const SizedBox(height: 8),
        const Callout('A coupon costs less on games with a higher house advantage; restricting coupons to the lowest-edge bets makes them more expensive (p.257). A study at a Las Vegas casino found no significant link between match play redeemed and blackjack cash drop (p.258–259).'),
        const BookRefChip(Promotions.refMatch),
      ]),
    ]);
  }
}

class _Program extends ConsumerStatefulWidget {
  const _Program();
  @override
  ConsumerState<_Program> createState() => _ProgramState();
}

class _ProgramState extends _CalcState<_Program> {
  @override
  Widget build(BuildContext context) {
    final tax = ref.watch(settingsProvider).gamingTaxRate;
    ({double beforeTax, double tax, double beforeLabor, double labor, double net}) pnl(double h, double b) => Promotions.programPnL(
          hours: h, avgBet: b, betsWonPerHour: v('bwh'), incentivesCost: v('np') * (0.5 - v('ha') / 200) + v('np2') * (0.5 - v('ha') / 200),
          cashAwards: v('cash'), mealDiscounts: v('meals'), roomDiscountLoss: v('room'), laborPerHour: v('labor'), tax: tax);
    final min = pnl(v('hours'), v('bet'));
    double? breakEvenBet;
    for (var b = 1.0; b <= 5000; b += 1) {
      if (pnl(v('hours'), b).net >= 0) {
        breakEvenBet = b;
        break;
      }
    }
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: "Package program (gambler's spree)", subtitle: 'Answer the four questions before approving (p.261)', children: [
        FieldGrid(children: [
          nf('hours', 'Minimum hours of play required', '8'), nf('bet', 'Minimum average bet', '5', prefix: '\$ '),
          nf('bwh', 'Bets won per hour', '1', helper: 'BJ ≈ 1.2, pass line ≈ 0.65, roulette ≈ 3.7 (p.266)'),
          nf('ha', 'House advantage for coupons', '1.5', suffix: '%'),
          nf('np', 'Nonnegotiables on arrival (face)', '50', prefix: '\$ '), nf('np2', 'Match play on qualifying (face)', '150', prefix: '\$ '),
          nf('cash', 'Cash award on qualifying', '100', prefix: '\$ '), nf('meals', 'Meal discounts given', '30', prefix: '\$ '),
          nf('room', 'Room revenue given up vs fair rate', '10', prefix: '\$ '), nf('labor', 'Table labor per player-hour', '3.53', prefix: '\$ '),
        ]),
      ]),
      SectionCard(title: 'Answers', children: [
        MetricGrid([
          Metric('1 · Result at minimum play', money(min.net), color: min.net < 0 ? Colors.red.shade700 : Colors.green.shade700),
          Metric('2 · Break-even average bet', breakEvenBet == null ? '> \$5,000' : money0(breakEvenBet), note: 'at ${numf(v('hours'))} hours'),
          Metric('Casino win at minimum', money(v('hours') * v('bet') * v('bwh'))),
          Metric('Gaming tax', money(min.tax)),
        ]),
        const SizedBox(height: 8),
        const Text('3 · Is play well above break-even realistic for players attracted by this offer?  4 · Is there another reason to run it even if it loses?'),
        const SizedBox(height: 8),
        const Callout("Rules from the book: don't copy a competitor's program; don't accept one whose results can't be quantified; separate hype from facts; beware \"trust me, you'll make a profit\" (p.267). Design the program to break even if everyone plays the minimum (p.263)."),
        const BookRefChip(Promotions.refSpree),
      ]),
    ]);
  }
}

class _Rebate extends ConsumerStatefulWidget {
  const _Rebate();
  @override
  ConsumerState<_Rebate> createState() => _RebateState();
}

class _RebateState extends _CalcState<_Rebate> {
  BaccaratSide side = BaccaratSide.banker;
  @override
  Widget build(BuildContext context) {
    final n = v('hands').round().clamp(1, 2000);
    final r = v('rebate') / 100;
    final base = side == BaccaratSide.banker ? 0.010579 : 0.012351;
    final eff = Rebates.effectiveAdvantageBaccarat(hands: n, rebate: r, side: side);
    final equiv = Rebates.equivalentBet(v('bet'), eff, base);
    final macd = Rebates.macdonaldCost(r, n, base);
    final effN = v('largest') > 0 ? Rebates.effectiveHands(v('wagered'), v('largest')) : null;
    final schedule = Rebates.graduatedSchedule(handLevels: const [50, 100, 250, 500, 650, 1000, 2000], rebateSteps: const [0.05, 0.10, 0.15, 0.20, 0.25], floor: v('floor') / 100, side: side);
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: 'Rebate on loss — baccarat, flat betting', subtitle: 'Exact calculation over every outcome; reproduces Tables 15.1–15.4 and 16.1', children: [
        SegmentedButton<BaccaratSide>(segments: const [ButtonSegment(value: BaccaratSide.banker, label: Text('Banker bets')), ButtonSegment(value: BaccaratSide.player, label: Text('Player bets'))],
            selected: {side}, onSelectionChanged: (s) => setState(() => side = s.first)),
        const SizedBox(height: 12),
        FieldGrid(children: [nf('hands', 'Hands played (non-tie)', '300', min: 1, max: 2000), nf('rebate', 'Rebate on actual loss', '10', suffix: '%', max: 100), nf('bet', 'Flat bet', '1000', prefix: '\$ ')]),
      ]),
      SectionCard(title: 'Effect', children: [
        MetricGrid([
          Metric('House advantage without rebate', pct(base, 3)),
          Metric('Effective advantage with rebate', pct(eff, 3), color: eff < 0 ? Colors.red.shade700 : null, note: eff < 0 ? 'Player has the edge' : null),
          Metric('Theo given up', pct(1 - eff / base, 1)),
          Metric('Equivalent bet without rebate', money0(equiv)),
          Metric('MacDonald quick estimate', '${pct(macd, 1)} of theo', note: 'approximation, level betting'),
        ]),
        const SizedBox(height: 8),
        const Callout('A rebate applies only to losses, so short play makes it far more expensive: at 50 hands a 20% rebate hands the player the edge (Table 16.1). Assume banker bets, round hands DOWN, and keep the right to cancel if betting varies widely (p.292–293).'),
      ]),
      SectionCard(title: 'Variable betting', subtitle: 'Effective hands = total wagered ÷ largest bet (MacDonald, p.288)', children: [
        FieldGrid(children: [nf('wagered', 'Total wagered', '1999', prefix: '\$ '), nf('largest', 'Largest single bet', '1000', prefix: '\$ ', min: 0.01),
          Metric('Effective hands', effN == null ? '—' : effN.toStringAsFixed(2))]),
      ]),
      SectionCard(title: 'Graduated schedule', subtitle: 'Largest rebate that keeps the effective advantage at or above the floor (p.291)', children: [
        FieldGrid(children: [nf('floor', 'Minimum advantage after rebate', '0.75', suffix: '%')]),
        const SizedBox(height: 8),
        SimpleTable(columns: const ['Hands played (at least)', 'Maximum rebate'], rows: [
          for (final e in schedule.entries) [Text('${e.key}'), Text(e.value == 0 ? 'None' : pct(e.value, 0))]
        ]),
        const SizedBox(height: 8),
        const Refs([Rebates.ref, Rebates.refPremium]),
      ]),
    ]);
  }
}

class _Premium extends ConsumerStatefulWidget {
  const _Premium();
  @override
  ConsumerState<_Premium> createState() => _PremiumState();
}

class _PremiumState extends _CalcState<_Premium> {
  @override
  Widget build(BuildContext context) {
    final tax = ref.watch(settingsProvider).gamingTaxRate;
    final hands = v('hours') * v('hph');
    final d = PremiumDeal(
      creditLine: v('line'), betPctOfLine: v('betpct') / 100, hours: v('hours'), handsPerHour: v('hph'), discountOnLoss: v('disc') / 100,
      compPctOfTheo: v('comp') / 100, compVariableCostPct: v('var') / 100, airfare: v('air'), walkInMoney: v('walk'), otherCosts: v('other'), gamingTax: tax,
    );
    final ok = hands >= 1 && hands <= 2000 && d.bet > 0;
    final r = ok ? PremiumDeals.evaluate(d) : null;
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: 'Premium baccarat deal', subtitle: 'Banker bets, level betting — Table 16.2 method', children: [
        FieldGrid(children: [
          nf('line', 'Credit line / front money', '150000', prefix: '\$ '), nf('betpct', 'Average bet as % of line', '2', suffix: '%'),
          nf('hours', 'Hours of play on the trip', '9'), nf('hph', 'Hands per hour', '60', min: 1),
          nf('disc', 'Discount on loss', '10', suffix: '%', max: 100), nf('comp', 'RFB comps as % of theo', '45', suffix: '%'),
          nf('var', 'Variable cost of comps (% of retail)', '45', suffix: '%'), nf('air', 'Airfare allowance', '9000', prefix: '\$ '),
          nf('walk', 'Walk-in money / cash incentives', '0', prefix: '\$ '), nf('other', 'Other costs (rep commission, gifts)', '0', prefix: '\$ '),
        ]),
      ]),
      SectionCard(title: 'Result', children: [
        if (r == null) const Text('Hands on the trip must be between 1 and 2,000 and the bet above zero.'),
        if (r != null) ...[
          MetricGrid([
            Metric('Total wagered', money0(d.wagered), note: '${d.hands} hands × ${money0(d.bet)}'),
            Metric('Effective advantage', pct(r.effectiveAdvantage, 3), note: 'after ${pct(d.discountOnLoss, 0)} discount'),
            Metric('Theoretical win', money0(r.theo)),
            Metric('RFB cost', money0(r.rfbCost)),
            Metric('Gaming tax', money0(r.tax)),
            Metric('Contribution', money0(r.contribution), color: r.contribution < 0 ? Colors.red.shade700 : Colors.green.shade700),
            Metric('Chance the casino loses the trip', pct(r.probabilityCasinoLoses, 1)),
          ]),
          const SizedBox(height: 8),
          const Callout('Book example: \$1.62M of wagers contributed about \$280 — roughly what a quarter-slot player gives in nine hours (p.308). Condition discounts on a minimum number of hands; never pool losses across games; use the post-discount advantage when awarding comps (p.310–318).'),
        ],
        const BookRefChip(PremiumDeals.ref),
      ]),
    ]);
  }
}

class _DeadChips extends ConsumerStatefulWidget {
  const _DeadChips();
  @override
  ConsumerState<_DeadChips> createState() => _DeadChipsState();
}

class _DeadChipsState extends _CalcState<_DeadChips> {
  BaccaratSide side = BaccaratSide.banker;
  @override
  Widget build(BuildContext context) {
    final pOther = side == BaccaratSide.banker ? GameMath.pPlayer : GameMath.pBank;
    final ha = side == BaccaratSide.banker ? 0.010579 : 0.012351;
    final bonus = v('bonus') / 100;
    final eff = Promotions.deadChipEffectiveAdvantage(bonusPct: bonus, pOtherSideWins: pOther, houseAdvantage: ha);
    final wash = Promotions.deadChipWash(deadChips: v('cash') * (1 + bonus), pOtherSideWins: pOther, houseAdvantage: ha, betSize: v('bet') <= 0 ? 1 : v('bet'), handsPerHour: v('hph') <= 0 ? 1 : v('hph'));
    final net = Promotions.deadChipRound(cash: v('cash'), bonusPct: bonus, pOtherSideWins: pOther, houseAdvantage: ha, gamingTax: ref.watch(settingsProvider).gamingTaxRate);
    final half = Promotions.deadChipBonusForReduction(reduction: 0.5, pOtherSideWins: pOther, houseAdvantage: ha);
    return PageBody(maxWidth: 950, children: [
      SectionCard(title: 'Dead-chip program', subtitle: 'All buy-ins are issued as dead chips; winning bets are paid in live chips (p.271)', children: [
        SegmentedButton<BaccaratSide>(segments: const [ButtonSegment(value: BaccaratSide.banker, label: Text('Banker bets')), ButtonSegment(value: BaccaratSide.player, label: Text('Player bets'))],
            selected: {side}, onSelectionChanged: (s) => setState(() => side = s.first)),
        const SizedBox(height: 12),
        FieldGrid(children: [nf('cash', 'Cash buy-in', '100000', prefix: '\$ '), nf('bonus', 'Dead-chip bonus', '1.2', suffix: '%'), nf('bet', 'Bet size', '1000', prefix: '\$ ', min: 1), nf('hph', 'Hands per hour', '60', min: 1)]),
      ]),
      SectionCard(title: 'Result per buy-in', children: [
        MetricGrid([
          Metric('Effective house advantage', pct(eff, 3), note: 'from ${pct(ha, 3)}'),
          Metric('Wagers to wash the chips', money0(wash.wagers)),
          Metric('Time to wash', '${wash.hours.toStringAsFixed(1)} h'),
          Metric('Casino result after bonus', money0(net.casinoWin)),
          Metric('After gaming tax', money0(net.net), color: net.net < 0 ? Colors.red.shade700 : null),
          Metric('Bonus that halves the edge', pct(half, 2)),
        ]),
        const SizedBox(height: 8),
        const Callout('Issue chips no smaller than 1% of the purchase; collect the banker commission only in live chips; never give only the bonus in dead chips — that is a "player bonanza" (p.271–274).'),
        const BookRefChip(Promotions.refDeadChip),
      ]),
    ]);
  }
}

class _CompSchedule extends ConsumerStatefulWidget {
  const _CompSchedule();
  @override
  ConsumerState<_CompSchedule> createState() => _CompScheduleState();
}

class _CompScheduleState extends _CalcState<_CompSchedule> {
  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    final a = ActionCriteriaAssumptions(
      betPctOfCredit: v('bet') / 100,
      betsWonPerHour: {'Blackjack & Baccarat': v('bj'), 'Dice': v('dice'), 'Roulette': v('roul')},
      hoursPerNight: v('hrs'), nights: v('nights').round().clamp(1, 30), markersPctOfLine: v('mk') / 100, badDebtPctOfMarkers: v('bd') / 100, gamingTax: s.gamingTaxRate,
    );
    final valid = v('bj') > 0 && v('dice') > 0 && v('roul') > 0 && v('hrs') > 0;
    const lines = [3000.0, 5000.0, 7500.0, 10000.0, 15000.0, 20000.0, 25000.0, 50000.0];
    return PageBody(children: [
      SectionCard(title: 'Player action criteria', subtitle: 'Minimum average bet by game for each credit level — Tables 15.5–15.6', children: [
        FieldGrid(children: [
          nf('bet', 'Expected bet as % of line', '2'), nf('hrs', 'Hours of play per night', '4', min: 0.1), nf('nights', 'Nights per trip', '3', min: 1),
          nf('bj', 'Bets won / hour — BJ & baccarat', '1.00', min: 0.01), nf('dice', 'Bets won / hour — dice', '0.38', min: 0.01), nf('roul', 'Bets won / hour — roulette', '3.41', min: 0.01),
          nf('mk', 'Markers transferred as % of line', '60'), nf('bd', 'Bad debt as % of markers', '3.5'),
        ]),
      ]),
      SectionCard(title: 'Schedule', children: [
        if (!valid) const Text('Enter positive values for hours and bets won per hour.'),
        if (valid)
          SimpleTable(columns: const ['Credit line', 'BJ & baccarat bet', 'Dice bet', 'Roulette bet', 'Theo / trip', 'Bad debt', 'Taxes', 'Available for comps', 'Comp level'], rows: [
            for (final l in lines)
              () {
                final r = ActionCriteria.row(l, a);
                final comp = r.availableForComps;
                final level = comp < 500 ? 'RO' : comp < 1000 ? 'RF' : 'RFB';
                return [
                  Text(money0(l)), Text(money0(r.requiredBet['Blackjack & Baccarat']!)), Text(money0(r.requiredBet['Dice']!)), Text(money0(r.requiredBet['Roulette']!)),
                  Text(money0(r.theo)), Text(money0(r.badDebt)), Text(money0(r.taxes)), Text(money0(comp)), Text(level),
                ];
              }()
          ]),
        const SizedBox(height: 8),
        const Text('Bet × hours is interchangeable: \$100 for 4 hours = \$50 for 8 hours = \$200 for 2 hours. Comp level shown is an app guide (RO < \$500 ≤ RF < \$1,000 ≤ RFB of comp budget); set your own room and food costs as in Table 15.6.'),
        const SizedBox(height: 8),
        const Refs([Comps.refCriteria, Comps.ref]),
      ]),
    ]);
  }
}
