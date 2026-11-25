import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/util/fmt.dart';
import '../../domain/entities/hold_summary.dart';

/// Hold by gaming day against the objective band (drop-weighted base hold ± tolerance).
/// Bars are neutral and the latest day is the accent. Single days swing widely, so days
/// are not flagged; the ±tolerance rule is applied per table over the period (Tables page).
/// Hovering a bar shows that day's figures in the header line.
class HoldChart extends StatefulWidget {
  const HoldChart({super.key, required this.days, required this.tolerance, this.height = 240});

  final List<DailyHold> days;
  final double tolerance;
  final double height;

  @override
  State<HoldChart> createState() => _HoldChartState();
}

class _HoldChartState extends State<HoldChart> {
  int? _hover;

  double get _objective {
    final drop = widget.days.fold<double>(0, (a, d) => a + d.drop);
    final w = widget.days.fold<double>(0, (a, d) => a + d.baseWeighted);
    return drop == 0 ? 0 : w / drop;
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final days = widget.days;
    final played = days.where((d) => d.hasPlay).toList();
    final shown = _hover ?? (played.isEmpty ? days.length - 1 : days.lastIndexWhere((d) => d.hasPlay));
    final d = days[shown];
    final obj = _objective;
    final mono = TextStyle(fontFamily: monoFamily, fontFamilyFallback: monoFallback, fontSize: 11, color: t.colorScheme.onSurfaceVariant);

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      // Figures for the day under the pointer (latest day by default).
      Wrap(spacing: 24, runSpacing: 4, crossAxisAlignment: WrapCrossAlignment.end, children: [
        _Figure(label: _dayLabel(d.day), value: d.hasPlay ? pct(d.hold, 1) : '—', big: true),
        _Figure(label: 'Drop', value: money0(d.drop)),
        _Figure(label: 'Win', value: money0(d.win)),
        _Figure(label: 'Objective', value: d.hasPlay ? pct(d.objective, 1) : '—'),
      ]),
      const SizedBox(height: 16),
      SizedBox(
        height: widget.height,
        child: LayoutBuilder(builder: (context, c) {
          const left = 44.0, bottom = 22.0;
          final n = days.length;
          final slot = (c.maxWidth - left) / n;
          return MouseRegion(
            onExit: (_) => setState(() => _hover = null),
            onHover: (e) {
              final i = ((e.localPosition.dx - left) / slot).floor();
              final next = i >= 0 && i < n ? i : null;
              if (next != _hover) setState(() => _hover = next);
            },
            child: CustomPaint(
              size: Size(c.maxWidth, widget.height),
              painter: _HoldPainter(
                days: days,
                objective: obj,
                tolerance: widget.tolerance,
                highlight: shown,
                hovering: _hover != null,
                left: left,
                bottom: bottom,
                grid: t.colorScheme.outlineVariant,
                bar: t.colorScheme.onSurface.withValues(alpha: t.brightness == Brightness.dark ? 0.28 : 0.16),
                accent: t.brightness == Brightness.dark ? Brand.lime : Brand.forest,
                band: AppPalette.of(context).tile,
                bandLine: (t.brightness == Brightness.dark ? Brand.lime : Brand.forest).withValues(alpha: 0.45),
                label: mono,
              ),
            ),
          );
        }),
      ),
      const SizedBox(height: 12),
      Wrap(spacing: 16, runSpacing: 4, children: [
        _Key(color: AppPalette.of(context).tile, border: true, text: 'Objective ${pct(obj, 1)} ± ${pct(widget.tolerance, 0)}'),
        _Key(color: (t.brightness == Brightness.dark ? Brand.lime : Brand.forest), text: _hover == null ? 'Latest gaming day' : 'Selected day'),
      ]),
    ]);
  }

  static const _wd = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  String _dayLabel(DateTime d) => '${_wd[d.weekday - 1]} ${date(d)}';
}

class _Figure extends StatelessWidget {
  const _Figure({required this.label, required this.value, this.big = false});
  final String label, value;
  final bool big;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
      Text(label, style: t.textTheme.labelMedium),
      const SizedBox(height: 2),
      Text(value, style: big ? t.textTheme.headlineSmall : t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500)),
    ]);
  }
}

class _Key extends StatelessWidget {
  const _Key({required this.color, required this.text, this.border = false});
  final Color color;
  final String text;
  final bool border;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: 12, height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
          border: border ? Border.all(color: (t.brightness == Brightness.dark ? Brand.lime : Brand.forest).withValues(alpha: 0.45)) : null,
        ),
      ),
      const SizedBox(width: 8),
      Text(text, style: t.textTheme.bodySmall),
    ]);
  }
}

class _HoldPainter extends CustomPainter {
  _HoldPainter({
    required this.days,
    required this.objective,
    required this.tolerance,
    required this.highlight,
    required this.hovering,
    required this.left,
    required this.bottom,
    required this.grid,
    required this.bar,
    required this.accent,
    required this.band,
    required this.bandLine,
    required this.label,
  });

  final List<DailyHold> days;
  final double objective, tolerance, left, bottom;
  final int highlight;
  final bool hovering;
  final Color grid, bar, accent, band, bandLine;
  final TextStyle label;

  void _text(Canvas c, String s, Offset at, {TextAlign align = TextAlign.left}) {
    final tp = TextPainter(text: TextSpan(text: s, style: label), textDirection: TextDirection.ltr)..layout();
    final dx = switch (align) { TextAlign.right => at.dx - tp.width, TextAlign.center => at.dx - tp.width / 2, _ => at.dx };
    tp.paint(c, Offset(dx, at.dy - tp.height / 2));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height - bottom;
    final w = size.width - left;
    final holds = days.where((d) => d.hasPlay).map((d) => d.hold);
    final hi = [objective + tolerance, ...holds].reduce(math.max);
    final lo = [0.0, ...holds].reduce(math.min);
    // Round the scale to 5-point steps.
    final top = ((hi * 20).floor() + 1) / 20;
    final floor = (lo * 20).floor() / 20;
    double y(double v) => h - (v - floor) / (top - floor) * h;

    final gridPaint = Paint()..color = grid..strokeWidth = 1;
    for (var v = floor; v <= top + 1e-9; v += 0.05) {
      canvas.drawLine(Offset(left, y(v)), Offset(size.width, y(v)), gridPaint);
      _text(canvas, '${(v * 100).round()}%', Offset(left - 8, y(v)), align: TextAlign.right);
    }

    // Objective band.
    if (objective > 0) {
      final r = Rect.fromLTRB(left, y(objective + tolerance), size.width, y(math.max(floor, objective - tolerance)));
      canvas.drawRect(r, Paint()..color = band);
      final dash = Paint()..color = bandLine..strokeWidth = 1;
      for (var x = left; x < size.width; x += 6) {
        canvas.drawLine(Offset(x, y(objective)), Offset(math.min(x + 3, size.width), y(objective)), dash);
      }
    }

    final slot = w / days.length;
    final bw = math.min(28.0, slot * 0.56);
    for (var i = 0; i < days.length; i++) {
      final d = days[i];
      final cx = left + slot * i + slot / 2;
      final everyOther = days.length > 10 && i.isOdd && i != highlight;
      if (!everyOther) _text(canvas, '${d.day.day}', Offset(cx, h + bottom / 2 + 2), align: TextAlign.center);
      if (!d.hasPlay) continue;
      final selected = i == highlight;
      var color = selected ? accent : bar;
      if (hovering && !selected) color = color.withValues(alpha: color.a * 0.7);
      final y0 = y(0.0 < floor ? floor : 0.0);
      final y1 = y(d.hold);
      final rect = Rect.fromLTRB(cx - bw / 2, math.min(y0, y1), cx + bw / 2, math.max(y0, y1));
      canvas.drawRRect(
        RRect.fromRectAndCorners(rect, topLeft: const Radius.circular(4), topRight: const Radius.circular(4)),
        Paint()..color = color,
      );
    }
    canvas.drawLine(Offset(left, y(math.max(0.0, floor))), Offset(size.width, y(math.max(0.0, floor))), Paint()..color = grid.withValues(alpha: 1)..strokeWidth = 1);
  }

  @override
  bool shouldRepaint(_HoldPainter old) =>
      old.days != days || old.highlight != highlight || old.hovering != hovering || old.objective != objective || old.bar != bar;
}
