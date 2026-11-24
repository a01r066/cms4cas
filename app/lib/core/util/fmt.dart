import 'package:intl/intl.dart';

final _money = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
final _money0 = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
final _num = NumberFormat('#,##0.##');

String money(num v) => _money.format(v);
String money0(num v) => _money0.format(v);
String pct(num v, [int d = 2]) => '${(v * 100).toStringAsFixed(d)}%';
String numf(num v) => _num.format(v);
String dateTime(DateTime d) => DateFormat('yyyy-MM-dd HH:mm').format(d);
String date(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

double? parseNum(String? s) {
  if (s == null) return null;
  final t = s.replaceAll(',', '').replaceAll('\$', '').replaceAll('%', '').trim();
  if (t.isEmpty) return null;
  return double.tryParse(t);
}
