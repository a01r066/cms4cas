import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/widgets.dart';

class Chapter {
  final String title;
  final List<String> lines;
  const Chapter(this.title, this.lines);
}

class Term {
  final String term, definition;
  const Term(this.term, this.definition);
}

/// Decodes on the main isolate (loadString spawns an isolate for large files).
Future<String> _loadText(String key) async => utf8.decode((await rootBundle.load(key)).buffer.asUint8List());

final chaptersProvider = FutureProvider<List<Chapter>>((ref) async {
  final raw = await _loadText('assets/kb/book_notes.md');
  final out = <Chapter>[];
  String? title;
  var lines = <String>[];
  for (final l in const LineSplitter().convert(raw)) {
    if (l.startsWith('## ')) {
      if (title != null) out.add(Chapter(title, lines));
      title = l.substring(3).trim();
      lines = [];
    } else if (title != null && l.trim().startsWith('- ')) {
      lines.add(l.trim().substring(2));
    }
  }
  if (title != null) out.add(Chapter(title, lines));
  return out;
});

final glossaryProvider = FutureProvider<List<Term>>((ref) async {
  final raw = jsonDecode(await _loadText('assets/kb/glossary.json')) as List;
  return raw.map((e) => Term(e['term'] as String, e['definition'] as String)).toList();
});

/// Knowledge library: chapter notes (book knowledge with page refs) and the glossary.
class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});
  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  String q = '';
  @override
  Widget build(BuildContext context) {
    final chapters = ref.watch(chaptersProvider);
    final glossary = ref.watch(glossaryProvider);
    final ql = q.toLowerCase();
    return Scaffold(
      body: PageBody(children: [
        TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search the book notes and glossary (e.g. "hold", "marker", "4 in 14")'),
          onChanged: (v) => setState(() => q = v),
        ),
        const SizedBox(height: 8),
        const Text('Notes summarise Kilby, Fox & Lucas, Casino Operations Management, 2nd ed. (Wiley, 2005) with page references. '
            'Lines marked "Software value" are this app\'s interpretation, not the authors\'.', style: TextStyle(fontSize: 12)),
        const SizedBox(height: 12),
        glossary.when(
          loading: () => const SizedBox(),
          error: (e, _) => Callout.bad('Glossary failed to load: $e'),
          data: (terms) {
            final hits = q.length < 2 ? const <Term>[] : terms.where((t) => t.term.toLowerCase().contains(ql) || t.definition.toLowerCase().contains(ql)).take(12).toList();
            if (hits.isEmpty) return const SizedBox();
            return SectionCard(title: 'Glossary', subtitle: 'Book glossary pp.379–390', children: [
              for (final t in hits) ListTile(dense: true, contentPadding: EdgeInsets.zero, title: Text(t.term, style: const TextStyle(fontWeight: FontWeight.w600)), subtitle: Text(t.definition)),
            ]);
          },
        ),
        chapters.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Callout.bad('Notes failed to load: $e'),
          data: (list) {
            final shown = list
                .map((c) => (c, q.length < 2 ? c.lines : c.lines.where((l) => l.toLowerCase().contains(ql)).toList()))
                .where((e) => q.length < 2 || e.$2.isNotEmpty || e.$1.title.toLowerCase().contains(ql))
                .toList();
            if (shown.isEmpty) return EmptyState('Nothing in the notes matches "$q".');
            return Card(
              child: Column(children: [
                for (final e in shown)
                  ExpansionTile(
                    initiallyExpanded: q.length >= 2,
                    title: Text(e.$1.title),
                    subtitle: Text('${e.$2.length} notes'),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                    children: [
                      for (final l in e.$2)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('•  ', style: TextStyle(color: l.startsWith('Software value') ? Colors.blue : null)),
                            Expanded(child: SelectableText(l, style: l.startsWith('Software value') ? const TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey) : null)),
                          ]),
                        ),
                    ],
                  ),
              ]),
            );
          },
        ),
      ]),
    );
  }
}
