import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness b) {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0B5D4B), brightness: b);
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: scheme.outlineVariant))),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder(), isDense: true),
    appBarTheme: AppBarTheme(backgroundColor: scheme.surface, scrolledUnderElevation: 1),
  );
}
