import 'package:flutter/material.dart';

/// CMS4Cas brand palette: deep forest green, lime accent, mint tiles.
abstract final class Brand {
  static const forest = Color(0xFF1D5A3C); // primary / headers / bottom bar
  static const forestDark = Color(0xFF123D28); // gradient end, pressed
  static const forestDeep = Color(0xFF0C2A1C); // dark-mode surfaces
  static const lime = Color(0xFFB4E86A); // call-to-action
  static const limeDark = Color(0xFF8CC63F);
  static const mint = Color(0xFFE6F2EA); // icon tiles, chips
  static const mintDeep = Color(0xFFCFE6D7);
  static const canvas = Color(0xFFF5F8F6); // page background
  static const ink = Color(0xFF14231B); // body text
  static const muted = Color(0xFF6B7C72);
  static const line = Color(0xFFE3EAE5);
  static const danger = Color(0xFFD64545);
  static const warning = Color(0xFFE0922F);
}

/// Extra brand tokens for widgets that need more than the ColorScheme.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.heroStart,
    required this.heroEnd,
    required this.onHero,
    required this.accent,
    required this.onAccent,
    required this.tile,
    required this.onTile,
    required this.navBar,
    required this.onNavBar,
    required this.navSelected,
  });

  final Color heroStart, heroEnd, onHero, accent, onAccent, tile, onTile, navBar, onNavBar, navSelected;

  LinearGradient get heroGradient =>
      LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [heroStart, heroEnd]);

  static const light = AppPalette(
    heroStart: Brand.forest,
    heroEnd: Brand.forestDark,
    onHero: Colors.white,
    accent: Brand.lime,
    onAccent: Brand.forestDark,
    tile: Brand.mint,
    onTile: Brand.forest,
    navBar: Brand.forest,
    onNavBar: Color(0xFFD5E6DB),
    navSelected: Color(0xFF2F7351),
  );

  static const dark = AppPalette(
    heroStart: Color(0xFF235F41),
    heroEnd: Brand.forestDeep,
    onHero: Colors.white,
    accent: Brand.lime,
    onAccent: Brand.forestDark,
    tile: Color(0xFF1C3A2A),
    onTile: Brand.lime,
    navBar: Color(0xFF173A28),
    onNavBar: Color(0xFFB9CFC1),
    navSelected: Color(0xFF2F7351),
  );

  static AppPalette of(BuildContext context) => Theme.of(context).extension<AppPalette>() ?? light;

  @override
  AppPalette copyWith({
    Color? heroStart, Color? heroEnd, Color? onHero, Color? accent, Color? onAccent,
    Color? tile, Color? onTile, Color? navBar, Color? onNavBar, Color? navSelected,
  }) =>
      AppPalette(
        heroStart: heroStart ?? this.heroStart, heroEnd: heroEnd ?? this.heroEnd, onHero: onHero ?? this.onHero,
        accent: accent ?? this.accent, onAccent: onAccent ?? this.onAccent, tile: tile ?? this.tile, onTile: onTile ?? this.onTile,
        navBar: navBar ?? this.navBar, onNavBar: onNavBar ?? this.onNavBar, navSelected: navSelected ?? this.navSelected,
      );

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      heroStart: l(heroStart, other.heroStart), heroEnd: l(heroEnd, other.heroEnd), onHero: l(onHero, other.onHero),
      accent: l(accent, other.accent), onAccent: l(onAccent, other.onAccent), tile: l(tile, other.tile), onTile: l(onTile, other.onTile),
      navBar: l(navBar, other.navBar), onNavBar: l(onNavBar, other.onNavBar), navSelected: l(navSelected, other.navSelected),
    );
  }
}

abstract final class Radii {
  static const card = 20.0;
  static const tile = 16.0;
  static const field = 14.0;
  static const pill = 100.0;
}

ThemeData buildTheme(Brightness b) {
  final dark = b == Brightness.dark;
  final base = ColorScheme.fromSeed(seedColor: Brand.forest, brightness: b);
  final scheme = dark
      ? base.copyWith(
          primary: Brand.lime,
          onPrimary: Brand.forestDark,
          primaryContainer: const Color(0xFF235F41),
          onPrimaryContainer: Colors.white,
          secondary: Brand.lime,
          onSecondary: Brand.forestDark,
          secondaryContainer: const Color(0xFF1C3A2A),
          onSecondaryContainer: Brand.lime,
          surface: const Color(0xFF0F2219),
          surfaceContainerLowest: const Color(0xFF0B1A13),
          surfaceContainerLow: const Color(0xFF132A1F),
          surfaceContainer: const Color(0xFF163024),
          surfaceContainerHigh: const Color(0xFF1A3629),
          surfaceContainerHighest: const Color(0xFF1F3D2F),
          outline: const Color(0xFF4F6B5C),
          outlineVariant: const Color(0xFF29443A),
          error: const Color(0xFFFF8A80),
        )
      : base.copyWith(
          primary: Brand.forest,
          onPrimary: Colors.white,
          primaryContainer: Brand.mint,
          onPrimaryContainer: Brand.forestDark,
          secondary: Brand.limeDark,
          onSecondary: Brand.forestDark,
          secondaryContainer: Brand.lime,
          onSecondaryContainer: Brand.forestDark,
          tertiary: const Color(0xFF3A7D5C),
          surface: Colors.white,
          onSurface: Brand.ink,
          onSurfaceVariant: Brand.muted,
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: Brand.canvas,
          surfaceContainer: const Color(0xFFF0F5F2),
          surfaceContainerHigh: const Color(0xFFEAF1EC),
          surfaceContainerHighest: const Color(0xFFE3ECE6),
          outline: const Color(0xFFB7C6BD),
          outlineVariant: Brand.line,
          error: Brand.danger,
        );
  final canvas = dark ? const Color(0xFF0B1A13) : Brand.canvas;
  final palette = dark ? AppPalette.dark : AppPalette.light;

  final baseText = (dark ? Typography.material2021().white : Typography.material2021().black)
      .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);
  final text = baseText.copyWith(
    headlineLarge: baseText.headlineLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
    headlineMedium: baseText.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
    headlineSmall: baseText.headlineSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.3),
    titleLarge: baseText.titleLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.2),
    titleMedium: baseText.titleMedium?.copyWith(fontWeight: FontWeight.w700),
    titleSmall: baseText.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    labelLarge: baseText.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    labelMedium: baseText.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
    bodySmall: baseText.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
  );

  const pill = StadiumBorder();
  // Not Size.fromHeight: an infinite min width breaks buttons inside Rows/Wraps.
  const buttonSize = Size(64, 46);
  const buttonPadding = EdgeInsets.symmetric(horizontal: 22, vertical: 12);
  final buttonText = text.labelLarge?.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  OutlineInputBorder field(Color c, [double w = 1]) =>
      OutlineInputBorder(borderRadius: BorderRadius.circular(Radii.field), borderSide: BorderSide(color: c, width: w));

  return ThemeData(
    useMaterial3: true,
    brightness: b,
    colorScheme: scheme,
    textTheme: text,
    scaffoldBackgroundColor: canvas,
    canvasColor: canvas,
    visualDensity: VisualDensity.standard,
    splashFactory: InkSparkle.splashFactory,
    extensions: [palette],
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 24, thickness: 1),
    appBarTheme: AppBarTheme(
      backgroundColor: canvas,
      surfaceTintColor: Colors.transparent,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      titleTextStyle: text.titleLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.w800),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: dark ? scheme.surfaceContainerLow : Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.card), side: BorderSide(color: scheme.outlineVariant)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: pill, minimumSize: buttonSize, padding: buttonPadding, textStyle: buttonText,
        backgroundColor: dark ? Brand.lime : Brand.forest, foregroundColor: dark ? Brand.forestDark : Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: pill, minimumSize: buttonSize, padding: buttonPadding, textStyle: buttonText, elevation: 0,
        backgroundColor: Brand.lime, foregroundColor: Brand.forestDark,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: pill, minimumSize: buttonSize, padding: buttonPadding, textStyle: buttonText,
        foregroundColor: dark ? Colors.white : Brand.forest, side: BorderSide(color: scheme.outline),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(shape: pill, textStyle: buttonText, foregroundColor: dark ? Brand.lime : Brand.forest),
    ),
    iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: scheme.onSurface)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Brand.lime, foregroundColor: Brand.forestDark, elevation: 2, shape: const StadiumBorder(),
      extendedTextStyle: buttonText,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: dark ? scheme.surfaceContainer : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: field(scheme.outlineVariant),
      enabledBorder: field(scheme.outlineVariant),
      disabledBorder: field(scheme.outlineVariant.withValues(alpha: 0.5)),
      focusedBorder: field(scheme.primary, 1.6),
      errorBorder: field(scheme.error),
      focusedErrorBorder: field(scheme.error, 1.6),
      labelStyle: TextStyle(color: scheme.onSurfaceVariant),
      floatingLabelStyle: TextStyle(color: scheme.primary, fontWeight: FontWeight.w600),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      side: BorderSide.none,
      backgroundColor: palette.tile,
      selectedColor: dark ? Brand.lime : Brand.forest,
      secondarySelectedColor: Brand.lime,
      checkmarkColor: dark ? Brand.forestDark : Colors.white,
      labelStyle: text.labelLarge?.copyWith(color: palette.onTile),
      secondaryLabelStyle: text.labelLarge?.copyWith(color: dark ? Brand.forestDark : Colors.white),
      iconTheme: IconThemeData(color: palette.onTile, size: 18),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        backgroundColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? (dark ? Brand.lime : Brand.forest) : null),
        foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? (dark ? Brand.forestDark : Colors.white) : scheme.onSurface),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? Colors.white : null),
      trackColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? (dark ? Brand.limeDark : Brand.forest) : null),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? (dark ? Brand.lime : Brand.forest) : null),
      checkColor: WidgetStatePropertyAll(dark ? Brand.forestDark : Colors.white),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: dark ? Brand.lime : Brand.forest,
      linearTrackColor: scheme.surfaceContainerHighest,
      linearMinHeight: 8,
      borderRadius: BorderRadius.circular(Radii.pill),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: palette.onTile,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.tile)),
      titleTextStyle: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: dark ? Brand.lime : Brand.forest,
      unselectedLabelColor: scheme.onSurfaceVariant,
      indicatorColor: dark ? Brand.lime : Brand.forest,
      labelStyle: text.labelLarge,
      dividerColor: scheme.outlineVariant,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: dark ? scheme.surfaceContainerLow : Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titleTextStyle: text.titleLarge,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: dark ? scheme.surfaceContainerLow : Colors.white,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Brand.forestDark,
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: Brand.lime,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.field)),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: dark ? scheme.surfaceContainerHigh : Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.tile)),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: Brand.forestDark, borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: palette.navBar,
      indicatorColor: palette.navSelected,
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.tile)),
      selectedIconTheme: const IconThemeData(color: Brand.lime),
      unselectedIconTheme: IconThemeData(color: palette.onNavBar),
      selectedLabelTextStyle: text.labelLarge?.copyWith(color: Colors.white),
      unselectedLabelTextStyle: text.labelLarge?.copyWith(color: palette.onNavBar, fontWeight: FontWeight.w500),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: dark ? scheme.surfaceContainerLow : Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: palette.tile,
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.tile)),
      iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(color: s.contains(WidgetState.selected) ? palette.onTile : scheme.onSurfaceVariant)),
      labelTextStyle: WidgetStateProperty.resolveWith((s) => text.labelLarge?.copyWith(
          color: s.contains(WidgetState.selected) ? palette.onTile : scheme.onSurface,
          fontWeight: s.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: palette.navBar,
      indicatorColor: palette.navSelected,
      indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.tile)),
      iconTheme: WidgetStateProperty.resolveWith(
          (s) => IconThemeData(color: s.contains(WidgetState.selected) ? Brand.lime : palette.onNavBar)),
      labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
          fontSize: 12,
          color: s.contains(WidgetState.selected) ? Colors.white : palette.onNavBar,
          fontWeight: s.contains(WidgetState.selected) ? FontWeight.w700 : FontWeight.w500)),
    ),
  );
}
