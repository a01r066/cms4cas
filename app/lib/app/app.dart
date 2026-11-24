import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routing/app_router.dart';
import '../core/theme/theme.dart';

class CmsApp extends ConsumerWidget {
  const CmsApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        title: 'CMS — Casino Management',
        debugShowCheckedModeBanner: false,
        theme: buildTheme(Brightness.light),
        darkTheme: buildTheme(Brightness.dark),
        routerConfig: ref.watch(routerProvider),
      );
}
