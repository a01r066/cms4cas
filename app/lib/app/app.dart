import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routing/app_router.dart';
import '../core/theme/theme.dart';
import '../flavors.dart';

class CmsApp extends ConsumerWidget {
  const CmsApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        title: F.title,
        debugShowCheckedModeBanner: !F.isProd,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        routerConfig: ref.watch(routerProvider),
        // Wide screens get the quieter desktop variant of the theme.
        builder: (context, child) {
          if (!isDesktop(context)) return child!;
          return Theme(data: buildTheme(Theme.of(context).brightness, desktop: true), child: child!);
        },
      );
}
