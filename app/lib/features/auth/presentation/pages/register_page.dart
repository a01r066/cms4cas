import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/route_names.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../flavors.dart';
import '../../../../shared/providers/backend_providers.dart';
import '../providers/auth_notifier.dart';

/// Email/password registration (Firebase backend). Creates the account and an
/// access request; an administrator then assigns the role in Settings.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _form = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    for (final c in [name, email, password, confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    final r = await ref.read(authNotifierProvider.notifier).register(
          name: name.text,
          email: email.text,
          password: password.text,
          confirmPassword: confirm.text,
        );
    if (!mounted) return;
    r.fold(
      (f) => showMsg(context, f.displayMessage, error: true),
      // Signed in without a role: the sign-in page shows the waiting state.
      (_) => context.go(Routes.signIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cloud = ref.watch(backendProvider) == Backend.firebase;
    final state = ref.watch(authNotifierProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Card(
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: !cloud
                    ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        const Callout('Registration needs the Firebase backend. On this device, an administrator adds users in Settings.'),
                        TextButton(onPressed: () => context.go(Routes.signIn), child: const Text('Back to sign in')),
                      ])
                    : Form(
                        key: _form,
                        child: AutofillGroup(
                          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            const Icon(Icons.person_add_alt_1_outlined, size: 48),
                            const SizedBox(height: 8),
                            Text('Create your account', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(height: 4),
                            Text(F.title, textAlign: TextAlign.center),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: name,
                              textCapitalization: TextCapitalization.words,
                              autofillHints: const [AutofillHints.name],
                              decoration: const InputDecoration(labelText: 'Full name'),
                              validator: (v) => (v ?? '').trim().length < 2 ? 'Enter your full name' : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              decoration: const InputDecoration(labelText: 'Work email'),
                              validator: (v) => (v ?? '').contains('@') ? null : 'Enter a valid email address',
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: password,
                              obscureText: obscure,
                              autofillHints: const [AutofillHints.newPassword],
                              decoration: InputDecoration(
                                labelText: 'Password',
                                helperText: 'At least ${AuthNotifier.minPasswordLength} characters',
                                suffixIcon: IconButton(
                                  tooltip: obscure ? 'Show password' : 'Hide password',
                                  icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                  onPressed: () => setState(() => obscure = !obscure),
                                ),
                              ),
                              validator: (v) => (v ?? '').length < AuthNotifier.minPasswordLength
                                  ? 'Use at least ${AuthNotifier.minPasswordLength} characters'
                                  : null,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: confirm,
                              obscureText: obscure,
                              autofillHints: const [AutofillHints.newPassword],
                              decoration: const InputDecoration(labelText: 'Confirm password'),
                              validator: (v) => v != password.text ? 'The passwords do not match' : null,
                              onFieldSubmitted: (_) => _submit(),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'After you register, an administrator assigns your role. You can sign in now, '
                              'but you will not see casino data until then.',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 16),
                            FilledButton(onPressed: state.busy ? null : _submit, child: const Text('Create account')),
                            TextButton(onPressed: () => context.go(Routes.signIn), child: const Text('I already have an account')),
                          ]),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
