import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef BeforeSignOutHook = Future<void> Function();

/// Callbacks that need the operator to be **still signed in** — e.g. flushing
/// writes queued while offline, which the rules would reject after sign-out.
/// [AuthNotifier.signOut] runs them, each time-boxed, then signs out.
class BeforeSignOutHooks {
  final _hooks = <String, BeforeSignOutHook>{};

  void register(String name, BeforeSignOutHook hook) => _hooks[name] = hook;
  void unregister(String name) => _hooks.remove(name);

  Future<void> runAll({Duration timeout = const Duration(seconds: 4)}) async {
    for (final e in _hooks.entries.toList()) {
      try {
        await e.value().timeout(timeout);
      } catch (err) {
        // Never block sign-out on a hook.
        debugPrint('before-sign-out hook "${e.key}" failed: $err');
      }
    }
  }
}

final beforeSignOutHooksProvider = Provider<BeforeSignOutHooks>((ref) => BeforeSignOutHooks());
