import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/theme.dart';
import '../util/fmt.dart';

/// Page body: scrollable, centred, max width; optional actions in the app bar.
class PageBody extends StatelessWidget {
  final List<Widget> children;
  final double maxWidth;
  const PageBody({super.key, required this.children, this.maxWidth = 1100});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        // Phones: leave room for the floating bottom bar.
        padding: EdgeInsets.fromLTRB(16, 8, 16, MediaQuery.sizeOf(context).width >= 1000 ? 48 : 120),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
          ),
        ),
      );
}

class SectionCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final List<Widget> children;
  const SectionCard({super.key, this.title, this.subtitle, this.trailing, required this.children});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LayoutBuilder(builder: (context, c) {
                final head = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title!, style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(subtitle!, style: t.textTheme.bodySmall)),
                ]);
                if (trailing == null) return head;
                if (c.maxWidth < 560) {
                  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [head, const SizedBox(height: 8), trailing!]);
                }
                return Row(children: [Expanded(child: head), trailing!]);
              }),
            ),
          ...children,
        ]),
      ),
    );
  }
}

/// "Book · Ch12 p.223" citation chip. Tap shows the full reference.
class BookRefChip extends StatelessWidget {
  final BookRef ref;
  final bool inline;
  const BookRefChip(this.ref, {super.key, this.inline = false});
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final chip = InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('From the book'),
            content: Text('${ref.label}\n\nKilby, Fox & Lucas, Casino Operations Management, 2nd ed. (Wiley, 2005) — '
                '${ref.chapter == null ? '' : 'Chapter ${ref.chapter}, '}p.${ref.pages}.'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: c.secondaryContainer, borderRadius: BorderRadius.circular(12)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.menu_book_outlined, size: 14, color: c.onSecondaryContainer),
            const SizedBox(width: 6),
            Flexible(child: Text(ref.short, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: c.onSecondaryContainer))),
          ]),
        ),
      );
    // Natural width; inside a Wrap or Row the Align is skipped so chips sit side by side.
    return inline ? chip : Align(alignment: Alignment.centerLeft, child: chip);
  }
}

class Refs extends StatelessWidget {
  final List<BookRef> refs;
  const Refs(this.refs, {super.key});
  @override
  Widget build(BuildContext context) =>
      Wrap(spacing: 8, runSpacing: 6, children: refs.map((r) => BookRefChip(r, inline: true)).toList());
}

/// Numeric text field with validation.
class NumField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? suffix;
  final String? prefix;
  final String? helper;
  final double? min;
  final double? max;
  final bool required;
  final bool integer;
  final ValueChanged<String>? onChanged;
  const NumField({
    super.key,
    required this.label,
    required this.controller,
    this.suffix,
    this.prefix,
    this.helper,
    this.min,
    this.max,
    this.required = true,
    this.integer = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.numberWithOptions(decimal: !integer, signed: min != null && min! < 0),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(integer ? r'[0-9,]' : r'[0-9.,\-]'))],
        decoration: InputDecoration(labelText: label, suffixText: suffix, prefixText: prefix, helperText: helper, helperMaxLines: 2),
        validator: (s) {
          final v = parseNum(s);
          if (v == null) return required ? 'Required' : null;
          if (min != null && v < min!) return 'Must be ≥ ${numf(min!)}';
          if (max != null && v > max!) return 'Must be ≤ ${numf(max!)}';
          return null;
        },
      );
}

/// Responsive grid of form fields (1–3 columns).
class FieldGrid extends StatelessWidget {
  final List<Widget> children;
  final double minWidth;
  const FieldGrid({super.key, required this.children, this.minWidth = 220});
  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (context, c) {
        final cols = (c.maxWidth / minWidth).floor().clamp(1, 4);
        final w = (c.maxWidth - (cols - 1) * 12) / cols;
        return Wrap(spacing: 12, runSpacing: 12, children: children.map((e) => SizedBox(width: w, child: e)).toList());
      });
}

class Metric extends StatelessWidget {
  final String label;
  final String value;
  final String? note;
  final Color? color;
  final IconData? icon;
  const Metric(this.label, this.value, {super.key, this.note, this.color, this.icon});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final p = AppPalette.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.cardTheme.color,
        border: Border.all(color: t.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(Radii.tile + 2),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: p.tile, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 16, color: p.onTile),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(child: Text(label, style: t.textTheme.labelMedium)),
        ]),
        const SizedBox(height: 8),
        Text(value, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: color)),
        if (note != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(note!, style: t.textTheme.bodySmall)),
      ]),
    );
  }
}

/// Dark-green gradient header card (Home hero, feature banners).
class HeroCard extends StatelessWidget {
  const HeroCard({super.key, required this.children, this.padding = const EdgeInsets.all(20)});
  final List<Widget> children;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(gradient: p.heroGradient, borderRadius: BorderRadius.circular(Radii.card + 4)),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        // Soft light sweep like the reference header.
        Positioned(
          right: -60, top: -80,
          child: Container(width: 220, height: 220,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.05))),
        ),
        Padding(
          padding: padding,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: p.onHero),
            child: IconTheme.merge(
              data: IconThemeData(color: p.onHero),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
            ),
          ),
        ),
      ]),
    );
  }
}

/// Mint rounded icon tile with a caption (quick access grid).
class QuickTile extends StatelessWidget {
  const QuickTile({super.key, required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(Radii.tile),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(color: p.tile, borderRadius: BorderRadius.circular(Radii.tile)),
            child: Icon(icon, color: p.onTile, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class MetricGrid extends StatelessWidget {
  final List<Metric> metrics;
  const MetricGrid(this.metrics, {super.key});
  @override
  Widget build(BuildContext context) => FieldGrid(minWidth: 170, children: metrics);
}

class Callout extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? color;
  const Callout(this.text, {super.key, this.icon = Icons.info_outline, this.color});
  factory Callout.warn(String t) => Callout(t, icon: Icons.warning_amber_rounded, color: Brand.warning);
  factory Callout.bad(String t) => Callout(t, icon: Icons.block, color: Brand.danger);
  factory Callout.good(String t) => Callout(t, icon: Icons.check_circle_outline, color: Brand.limeDark);
  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(Radii.field), border: Border.all(color: c.withValues(alpha: 0.25))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: c, size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ]),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final Widget? action;
  const EmptyState(this.message, {super.key, this.icon = Icons.inbox_outlined, this.action});
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(children: [
          Icon(icon, size: 40, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          if (action != null) Padding(padding: const EdgeInsets.only(top: 12), child: action!),
        ]),
      );
}

/// Shows [msg] now, replacing any message still on screen (messages never queue,
/// so an error is not hidden behind an earlier confirmation).
void showMsg(BuildContext context, String msg, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
    content: Text(msg),
    backgroundColor: error ? Colors.red.shade700 : null,
  ));
}

/// Simple data table that scrolls horizontally on narrow screens.
class SimpleTable extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final List<VoidCallback?>? onTap;
  const SimpleTable({super.key, required this.columns, required this.rows, this.onTap});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          headingRowHeight: 40,
          columnSpacing: 24,
          columns: columns.map((c) => DataColumn(label: Text(c, style: const TextStyle(fontWeight: FontWeight.w600)))).toList(),
          rows: [
            for (var i = 0; i < rows.length; i++)
              DataRow(cells: rows[i].map((w) => DataCell(w)).toList(), onSelectChanged: onTap?[i] == null ? null : (_) => onTap![i]!()),
          ],
        ),
      );
}

class NoAccess extends StatelessWidget {
  final String what;
  const NoAccess(this.what, {super.key});
  @override
  Widget build(BuildContext context) => Callout.warn('Your role does not allow $what. Ask an administrator if you need access.');
}
