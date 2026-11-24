import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../flavors.dart';
import '../../../../shared/providers/backend_providers.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_providers.dart';
import '../widgets/user_form.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cloud = ref.watch(backendProvider) == Backend.firebase;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  const Icon(Icons.casino_outlined, size: 48),
                  const SizedBox(height: 8),
                  Text(F.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  const Text('Operations tools from Casino Operations Management (2nd ed.)', textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ...(cloud ? _cloud() : _local()),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Local backend: pick the operator on this trusted device.
  List<Widget> _local() => ref.watch(localSignInUsersProvider).when(
        loading: () => [const Center(child: CircularProgressIndicator())],
        error: (e, _) => [Callout.bad('$e')],
        data: (list) => list.isEmpty
            ? [
                const Callout('First run on this device. Create the administrator account; other users are added in Settings.'),
                const SizedBox(height: 8),
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
                    onTap: () => ref.read(authNotifierProvider.notifier).signInAs(u.id),
                  ),
                const SizedBox(height: 8),
                const Text(
                  'Local mode keeps data on this device without passwords — for evaluation and training. '
                  'Use the Firebase backend for live operations (see README).',
                  style: TextStyle(fontSize: 12),
                ),
              ],
      );

  /// Firebase backend: email + password; the account also needs a CMS role.
  List<Widget> _cloud() {
    final state = ref.watch(authNotifierProvider);
    final uid = ref.watch(authUidProvider).value;
    final profile = ref.watch(currentUserProvider);
    final signedInWithoutRole = uid != null && profile.hasValue && profile.value == null;
    return [
      if (!signedInWithoutRole) ...[
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: password,
          obscureText: true,
          autofillHints: const [AutofillHints.password],
          decoration: const InputDecoration(labelText: 'Password'),
          onSubmitted: (_) => _signIn(),
        ),
      ],
      if (state.failure != null) Padding(padding: const EdgeInsets.only(top: 8), child: Callout.bad(state.failure!.displayMessage)),
      if (signedInWithoutRole) ...[
        const Callout('Signed in, but no CMS role is assigned to this account yet. Ask an administrator — '
            'or, if this is a new casino, set yourself up as the first administrator.'),
        TextButton(onPressed: () => showUserForm(context, ref, firstAdmin: true), child: const Text('Set up as first administrator')),
        TextButton(onPressed: () => ref.read(authNotifierProvider.notifier).signOut(), child: const Text('Use another account')),
      ],
      const SizedBox(height: 16),
      if (!signedInWithoutRole)
        FilledButton(onPressed: state.busy ? null : _signIn, child: const Text('Sign in')),
    ];
  }

  Future<void> _signIn() => ref.read(authNotifierProvider.notifier).signInWithEmail(email.text, password.text);
}
