import 'book_ref.dart';

/// Ch4 staffing method (pp.53–59).
class Staffing {
  static const ref = BookRef(4, '53–59', 'Staffing the casino');

  /// Stations per table: BJ 1, craps 3 (stick + 2 base), baccarat 3 (p.54).
  static const stationsPerTable = {'Blackjack': 1, 'Craps': 3, 'Baccarat': 3};

  /// Employees per shift = stations × (on + off) / on (p.54).
  static double perShift(num stations, {int onMinutes = 60, int offMinutes = 20}) =>
      stations * (onMinutes + offMinutes) / onMinutes;

  /// Payroll heads = weekly shifts ÷ days worked × 52 / (52 − vacation weeks) (p.56).
  static double payroll(double weeklyShifts, {int daysWorked = 5, int vacationWeeks = 2}) =>
      weeklyShifts / daysWorked * 52 / (52 - vacationWeeks);

  /// Floor stations: 1 per [tablesPerFloor] BJ tables; employees × 480/380, rounded up (pp.56–57).
  static int floorPerShift(int bjTables,
      {int tablesPerFloor = 4, int shiftMinutes = 480, int workedMinutes = 380}) {
    final stations = (bjTables / tablesPerFloor).ceil();
    return (stations * shiftMinutes / workedMinutes - 1e-9).ceil();
  }

  /// Full plan for one game: [stations][day][shift].
  static StaffingPlan plan(List<List<num>> stationsByDayShift,
      {int onMinutes = 60, int offMinutes = 20, int daysWorked = 5, int vacationWeeks = 2}) {
    final perDay = stationsByDayShift
        .map((shifts) => shifts.fold<double>(0, (a, s) => a + perShift(s, onMinutes: onMinutes, offMinutes: offMinutes)))
        .toList();
    final weekly = perDay.fold<double>(0, (a, b) => a + b);
    final formula = weekly / daysWorked;
    // Busiest day: the day's staff all must be on payroll that day (pp.57–59).
    final busiest = perDay.reduce((a, b) => a > b ? a : b);
    final base = formula > busiest ? formula : busiest;
    return StaffingPlan(
      shiftsPerDay: perDay,
      weeklyShifts: weekly,
      formulaHeads: formula,
      busiestDayHeads: busiest,
      payrollBeforeVacation: base,
      payrollWithVacation: base * 52 / (52 - vacationWeeks),
    );
  }
}

class StaffingPlan {
  final List<double> shiftsPerDay;
  final double weeklyShifts, formulaHeads, busiestDayHeads, payrollBeforeVacation, payrollWithVacation;
  const StaffingPlan({
    required this.shiftsPerDay,
    required this.weeklyShifts,
    required this.formulaHeads,
    required this.busiestDayHeads,
    required this.payrollBeforeVacation,
    required this.payrollWithVacation,
  });
  bool get busiestDayBinds => busiestDayHeads > formulaHeads;
}
