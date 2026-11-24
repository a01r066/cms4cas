import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/util/fmt.dart';
import '../../../core/widgets/widgets.dart';
import '../../settings/data/settings.dart';

const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const _shifts = ['Days', 'Swing', 'Grave'];

class StaffingPage extends StatelessWidget {
  const StaffingPage({super.key});
  @override
  Widget build(BuildContext context) => const DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(tabs: [Tab(text: 'Dealer & floor staffing'), Tab(text: 'Table opening economics')]),
          body: TabBarView(children: [_Staffing(), _Opening()]),
        ),
      );
}

class _Staffing extends ConsumerStatefulWidget {
  const _Staffing();
  @override
  ConsumerState<_Staffing> createState() => _StaffingState();
}

class _StaffingState extends ConsumerState<_Staffing> {
  String game = 'Blackjack';
  // Book example (p.53): blackjack tables open by day × shift.
  final tables = <String, List<List<int>>>{
    'Blackjack': [[40, 40, 20], [40, 40, 20], [40, 40, 20], [40, 40, 24], [60, 60, 24], [60, 60, 24], [48, 40, 20]],
    'Craps': [[8, 8, 2], [8, 8, 2], [8, 8, 2], [8, 8, 3], [10, 10, 3], [10, 10, 3], [8, 8, 2]],
    'Baccarat': [[2, 2, 1], [2, 2, 1], [2, 2, 1], [2, 2, 2], [3, 3, 2], [3, 3, 2], [2, 2, 1]],
  };
  final on = TextEditingController(text: '60');
  final off = TextEditingController(text: '20');
  final daysWorked = TextEditingController(text: '5');
  final vacation = TextEditingController(text: '2');
  final perFloor = TextEditingController(text: '4');

  @override
  Widget build(BuildContext context) {
    final grid = tables[game]!;
    final perTable = Staffing.stationsPerTable[game]!;
    final onM = (parseNum(on.text) ?? 60).round().clamp(1, 600), offM = (parseNum(off.text) ?? 20).round().clamp(0, 600);
    final dw = (parseNum(daysWorked.text) ?? 5).round().clamp(1, 7), vac = (parseNum(vacation.text) ?? 2).round().clamp(0, 20);
    final plan = Staffing.plan(grid.map((d) => d.map((t) => t * perTable).toList()).toList(), onMinutes: onM, offMinutes: offM, daysWorked: dw, vacationWeeks: vac);
    // Floor staff for blackjack only (1 per N tables, 480/380 cycle, rounded up).
    final pf = (parseNum(perFloor.text) ?? 4).round().clamp(1, 20);
    final floorPerShift = List.generate(3, (s) => List.generate(7, (d) => Staffing.floorPerShift(tables['Blackjack']![d][s], tablesPerFloor: pf)));
    final floorWeekly = List.generate(3, (s) => floorPerShift[s].fold<int>(0, (a, b) => a + b));
    return PageBody(children: [
      SectionCard(title: 'Tables open', subtitle: 'Enter the tables you plan to open by day and shift', children: [
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final g in tables.keys)
            ChoiceChip(label: Text(g), selected: g == game, onSelected: (_) => setState(() => game = g)),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            defaultColumnWidth: const FixedColumnWidth(72),
            columnWidths: const {0: FixedColumnWidth(70)},
            children: [
              TableRow(children: [const SizedBox(), for (final d in _days) Center(child: Text(d, style: const TextStyle(fontWeight: FontWeight.w600)))]),
              for (var s = 0; s < 3; s++)
                TableRow(children: [
                  Padding(padding: const EdgeInsets.only(top: 14), child: Text(_shifts[s])),
                  for (var d = 0; d < 7; d++)
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: TextFormField(
                        key: ValueKey('$game-$d-$s'),
                        initialValue: '${grid[d][s]}',
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(isDense: true),
                        onChanged: (v) => setState(() => grid[d][s] = (parseNum(v) ?? 0).round().clamp(0, 999)),
                      ),
                    ),
                ]),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text('$game: $perTable station${perTable == 1 ? '' : 's'} per table (p.54).'),
      ]),
      SectionCard(title: 'Assumptions', children: [
        FieldGrid(children: [
          NumField(label: 'Minutes dealing', controller: on, integer: true, min: 1, onChanged: (_) => setState(() {})),
          NumField(label: 'Minutes break', controller: off, integer: true, min: 0, onChanged: (_) => setState(() {})),
          NumField(label: 'Days worked per week', controller: daysWorked, integer: true, min: 1, max: 7, onChanged: (_) => setState(() {})),
          NumField(label: 'Vacation weeks per year', controller: vacation, integer: true, min: 0, max: 20, onChanged: (_) => setState(() {})),
          NumField(label: 'BJ tables per floorperson', controller: perFloor, integer: true, min: 1, onChanged: (_) => setState(() {})),
        ]),
      ]),
      SectionCard(title: '$game dealers', children: [
        MetricGrid([
          Metric('Dealer shifts per week', plan.weeklyShifts.toStringAsFixed(1)),
          Metric('Formula headcount', plan.formulaHeads.toStringAsFixed(2), note: 'shifts ÷ $dw days'),
          Metric('Busiest day needs', plan.busiestDayHeads.toStringAsFixed(1), color: plan.busiestDayBinds ? Colors.orange.shade800 : null),
          Metric('Dealers on payroll', plan.payrollWithVacation.toStringAsFixed(2), note: 'incl. $vac weeks vacation'),
        ]),
        if (plan.busiestDayBinds)
          Padding(padding: const EdgeInsets.only(top: 8), child: Callout.warn('Demand varies a lot by day: staff to the busiest day, not the weekly formula (p.57–59).')),
        const SizedBox(height: 8),
        SimpleTable(columns: ['', ..._days], rows: [
          ['Dealer shifts', ...plan.shiftsPerDay.map((x) => x.toStringAsFixed(1))].map((e) => Text(e)).toList(),
        ]),
      ]),
      SectionCard(title: 'Blackjack floorpersons', subtitle: '1 per $pf tables · works 380 of 480 minutes · round up each shift (p.56–57)', children: [
        SimpleTable(columns: ['', ..._days, 'Week', 'Payroll'], rows: [
          for (var s = 0; s < 3; s++)
            [Text(_shifts[s]), ...floorPerShift[s].map((x) => Text('$x')), Text('${floorWeekly[s]}'), Text(Staffing.payroll(floorWeekly[s].toDouble(), daysWorked: dw, vacationWeeks: vac).toStringAsFixed(2))],
        ]),
        const SizedBox(height: 8),
        const BookRefChip(Staffing.ref),
      ]),
    ]);
  }
}

class _Opening extends ConsumerStatefulWidget {
  const _Opening();
  @override
  ConsumerState<_Opening> createState() => _OpeningState();
}

class _OpeningState extends ConsumerState<_Opening> {
  final f = {
    'dealer': TextEditingController(text: '50'), 'floor': TextEditingController(text: '150'), 'burden': TextEditingController(text: '30'),
    'ratio': TextEditingController(text: '0.25'), 'ha': TextEditingController(text: '1'), 'bet': TextEditingController(text: '100'), 'players': TextEditingController(text: '28'),
  };
  double v(String k) => parseNum(f[k]!.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    final tax = ref.watch(settingsProvider).gamingTaxRate;
    final labor = 80 / 60 * v('dealer') * (1 + v('burden') / 100) + 480 / 380 * v('ratio') * v('floor') * (1 + v('burden') / 100);
    final perHour = labor / 8;
    final ha = v('ha') / 100;
    final players = v('players').round().clamp(1, 500);
    final hands = RatingDefaults.byId('blackjack').decisionsByPlayers;
    return PageBody(children: [
      SectionCard(title: 'Labor per table (8-hour shift)', subtitle: 'Dealer 60 on / 20 off; floor 1 per 4 games (p.250–251)', children: [
        FieldGrid(children: [
          for (final e in {'dealer': 'Dealer pay per shift', 'floor': 'Floorperson pay per shift', 'burden': 'Taxes & benefits %', 'ratio': 'Floorpersons per table', 'ha': 'House advantage %', 'bet': 'Average bet', 'players': 'Players to seat'}.entries)
            NumField(label: e.value, controller: f[e.key]!, min: 0, onChanged: (_) => setState(() {})),
        ]),
        const SizedBox(height: 8),
        MetricGrid([Metric('Labor per table per shift', money(labor)), Metric('Per hour', money(perHour))]),
      ]),
      SectionCard(title: 'Break-even average bet by players per table', subtitle: 'hands/hr × players × HA × (1 − tax) × bet = labor/hr (p.252–253)', children: [
        SimpleTable(columns: const ['Players', 'Hands/hr (Table 13.1)', 'Break-even bet'], rows: [
          for (final e in hands.entries)
            [Text('${e.key}'), Text('${e.value.toInt()}'), Text(ha <= 0 ? '—' : money(e.value <= 0 ? 0 : perHour / (e.value * e.key * ha * (1 - tax))))],
        ]),
      ]),
      SectionCard(title: 'Spread $players players over fewer or more tables', subtitle: 'Occupancy ↑ → hold ↓, margin ↑, profit ↓ (Table 13.2)', children: [
        SimpleTable(columns: const ['Players/table', 'Tables', 'Gross win/shift', 'Labor', 'Contribution', 'Margin'], rows: [
          for (final e in hands.entries)
            () {
              final t = (players / e.key).ceil();
              final win = e.key * e.value * v('bet') * ha * 8 * t;
              final lab = labor * t;
              return [Text('${e.key}'), Text('$t'), Text(money0(win)), Text(money0(lab)), Text(money0(win - lab)), Text(win == 0 ? '—' : pct((win - lab) / win, 0))];
            }()
        ]),
        const SizedBox(height: 8),
        const Text('Before gaming tax, as in Table 13.2. Assumes everyone plays all shift; hands per hour from Table 13.1. Fewer players per table earns more total contribution when the average bet is high enough.'),
        const SizedBox(height: 8),
        const Refs([BookRef(13, '250–254', 'High table occupancy may be hazardous to profit')]),
      ]),
    ]);
  }
}
