// Writes the demo data set as JSON for functions/scripts/seed-demo-data.js.
//
//   dart run tool/export_demo_data.dart [--out firebase/seed/demo_data.json]
//
// Same generator as Settings → Demo data, so Firebase and local data match.
// Dates are relative to now; the seeding script shifts them if the file is older.
import 'dart:convert';
import 'dart:io';

import 'package:cms_kiss/features/demo_data/data/demo_data_generator.dart';

void main(List<String> args) {
  final i = args.indexOf('--out');
  final out = File(i >= 0 && i + 1 < args.length ? args[i + 1] : 'firebase/seed/demo_data.json');
  final now = DateTime.now();
  final data = DemoData.build(now: now);
  out.parent.createSync(recursive: true);
  out.writeAsStringSync(const JsonEncoder.withIndent(' ').convert({
    'generatedAt': now.toIso8601String(),
    'prefix': DemoData.prefix,
    'collections': data,
    'logins': [for (final u in DemoData.users) {'uid': u.$1, 'name': u.$2, 'email': u.$5}],
  }));
  final n = data.values.fold<int>(0, (a, m) => a + m.length);
  stdout.writeln('✓ $n demo records → ${out.path}');
}
