import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';

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
    final waiting = uid != null && profile.hasValue && profile.value == null;
    if (waiting) return _waitingForRole(state.busy);
    return [
      AutofillGroup(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        ]),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: TextButton(onPressed: state.busy ? null : _forgotPassword, child: const Text('Forgot password?')),
      ),
      if (state.failure != null) Padding(padding: const EdgeInsets.only(bottom: 8), child: Callout.bad(state.failure!.displayMessage)),
      FilledButton(onPressed: state.busy ? null : _signIn, child: const Text('Sign in')),
      const SizedBox(height: 8),
      Wrap(alignment: WrapAlignment.center, crossAxisAlignment: WrapCrossAlignment.center, children: [
        const Text('New here?'),
        TextButton(onPressed: () => context.go(Routes.register), child: const Text('Create an account')),
      ]),
    ];
  }

  /// Signed in, but no CMS role yet (just registered, or not approved).
  List<Widget> _waitingForRole(bool busy) {
    final n = ref.read(authNotifierProvider.notifier);
    final verified = ref.read(authRepositoryProvider).emailVerified;
    return [
      const Callout('Your account is waiting for an administrator to assign a role. '
          'You will see the casino modules as soon as that is done — no need to sign in again.'),
      const SizedBox(height: 8),
      if (!verified) ...[
        Callout.warn('Please confirm your email address — we sent you a link.'),
        TextButton(
          onPressed: busy
              ? null
              : () async {
                  final r = await n.resendVerificationEmail();
                  if (mounted) r.fold((f) => showMsg(context, f.displayMessage, error: true), (_) => showMsg(context, 'Verification email sent'));
                },
          child: const Text('Resend verification email'),
        ),
      ],
      const Divider(),
      const Text('Setting up a new casino? The very first account may make itself the administrator.', style: TextStyle(fontSize: 12)),
      TextButton(onPressed: () => showUserForm(context, ref, firstAdmin: true), child: const Text('Set up as first administrator')),
      OutlinedButton(onPressed: busy ? null : n.signOut, child: const Text('Sign out')),
    ];
  }

  Future<void> _forgotPassword() async {
    final r = await ref.read(authNotifierProvider.notifier).sendPasswordReset(email.text);
    if (!mounted) return;
    r.fold(
      (f) => showMsg(context, f.displayMessage, error: true),
      (_) => showMsg(context, 'If an account exists for ${email.text.trim()}, a reset link is on its way.'),
    );
  }

  Future<void> _signIn() => ref.read(authNotifierProvider.notifier).signInWithEmail(email.text, password.text);
}
