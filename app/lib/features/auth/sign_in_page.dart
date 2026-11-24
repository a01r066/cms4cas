import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app_config.dart';
import '../../core/auth/roles.dart';
import '../../core/auth/session.dart';
import '../../core/widgets/widgets.dart';
import '../settings/presentation/settings_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});
  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool busy = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Icon(Icons.casino_outlined, size: 48),
                const SizedBox(height: 8),
                Text('CMS — Casino Management', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 4),
                const Text('Operations tools from Casino Operations Management (2nd ed.)', textAlign: TextAlign.center),
                const SizedBox(height: 24),
                if (kUseFirebase) ..._cloud() else ...users.when(
                  loading: () => [const Center(child: CircularProgressIndicator())],
                  error: (e, _) => [Callout.bad('$e')],
                  data: (list) => list.isEmpty
                      ? [
                          const Callout('First run on this device. Create the administrator account; other users are added in Settings.'),
                          FilledButton(onPressed: () => showUserForm(context, ref, firstAdmin: true), child: const Text('Create administrator')),
                        ]
                      : [
                          const Text('Local mode — choose who is working on this device:'),
                          const SizedBox(height: 8),
                          for (final u in list)
                            ListTile(
                              leading: const Icon(Icons.account_circle_outlined),
                              title: Text(u.name),
                              subtitle: Text(u.role.label),
                              onTap: () => ref.read(sessionProvider.notifier).signInAs(u.id),
                            ),
                          const SizedBox(height: 8),
                          const Text('Local mode keeps data on this device without passwords. Configure Firebase for shared, password-protected use (see README).', style: TextStyle(fontSize: 12)),
                        ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _cloud() => [
        TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
        TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
        if (error != null) Padding(padding: const EdgeInsets.only(top: 8), child: Callout.bad(error!)),
        if (ref.watch(sessionProvider) != null && ref.watch(currentUserProvider) == null)
          TextButton(onPressed: () => showUserForm(context, ref, firstAdmin: true), child: const Text('Set up as first administrator')),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: busy
              ? null
              : () async {
                  setState(() {
                    busy = true;
                    error = null;
                  });
                  try {
                    final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text);
                    final uid = cred.user!.uid;
                    final profile = (ref.read(usersProvider).value ?? const <AppUser>[]).where((u) => u.id == uid);
                    await ref.read(sessionProvider.notifier).signInAs(uid);
                    if (profile.isEmpty) {
                      error = 'Signed in, but no CMS role is assigned to this account yet. Ask an administrator — '
                          'or, if this is a new casino, set yourself up as the first administrator.';
                    }
                  } on FirebaseAuthException catch (e) {
                    error = e.message ?? 'Sign-in failed';
                  } finally {
                    if (mounted) setState(() => busy = false);
                  }
                },
          child: const Text('Sign in'),
        ),
      ];
}
