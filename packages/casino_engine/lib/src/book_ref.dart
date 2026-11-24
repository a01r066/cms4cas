/// A citation to the source book, shown in the UI next to every result.
class BookRef {
  final int? chapter;
  final String pages;
  final String label;
  const BookRef(this.chapter, this.pages, this.label);

  String get short => chapter == null ? 'Book · p.$pages' : 'Book · Ch$chapter p.$pages';

  @override
  String toString() => '$short — $label';
}
