import 'package:casino_engine/casino_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../shared/providers/backend_providers.dart';
import '../../domain/entities/app_role.dart';
import '../../domain/entities/app_user.dart';
import '../providers/auth_notifier.dart';

/// Add or edit an operator. Saving goes through the `setUserRole` action.
/// [firstAdmin]: the very first user of an empty casino sets themself up as admin.
Future<void> showUserForm(BuildContext context, WidgetRef ref, {AppUser? existing, bool firstAdmin = false}) async {
  final cloud = ref.read(backendProvider) == Backend.firebase;
  final name = TextEditingController(text: existing?.name);
  final email = TextEditingController(text: existing?.email);
  var role = existing?.role ?? (firstAdmin ? AppRole.admin : AppRole.pitSupervisor);
  CreditRole? credit = existing?.creditRole;
  final form = GlobalKey<FormState>();
  await showDialog<void>(
    context: context,
    barrierDismissible: !firstAdmin,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, set) => AlertDialog(
        title: Text(firstAdmin ? 'Create the first administrator' : existing == null ? 'Add user' : 'Edit user'),
        content: SizedBox(
          width: 420,
          child: Form(
            key: form,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: name,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Full name *'),
                validator: (v) => (v ?? '').trim().length < 2 ? 'Enter a name' : null,
              ),
              if (cloud && !firstAdmin)
                TextFormField(
                  controller: email,
                  enabled: existing == null,
                  decoration: const InputDecoration(
                      labelText: 'Sign-in email *', helperText: 'The account must already exist in Firebase Authentication'),
                  validator: (v) => existing == null && !(v ?? '').contains('@') ? 'Enter the user\'s email' : null,
                ),
              DropdownButtonFormField<AppRole>(
                isExpanded: true,
                initialValue: role,
                decoration: const InputDecoration(labelText: 'Role'),
                items: AppRole.values.map((r) => DropdownMenuItem(value: r, child: Text(r.label))).toList(),
                onChanged: firstAdmin ? null : (v) => set(() => role = v!),
              ),
              DropdownButtonFormField<CreditRole?>(
                isExpanded: true,
                initialValue: credit,
                decoration: const InputDecoration(
                    labelText: 'Credit signing authority', helperText: 'Only for users who sign credit decisions'),
                items: [
                  const DropdownMenuItem<CreditRole?>(value: null, child: Text('None')),
                  ...CreditRole.values.map((r) => DropdownMenuItem<CreditRole?>(value: r, child: Text(r.label))),
                ],
                onChanged: (v) => set(() => credit = v),
              ),
            ]),
          ),
        ),
        actions: [
          if (!firstAdmin) TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              if (!form.currentState!.validate()) return;
              final draft = AppUser(
                id: existing?.id ?? '',
                name: name.text.trim(),
                role: role,
                creditRole: credit,
                email: email.text.trim().isEmpty ? existing?.email : email.text.trim(),
              );
              final r = await ref.read(authNotifierProvider.notifier).saveUser(draft, firstAdmin: firstAdmin);
              if (!ctx.mounted) return;
              r.fold((f) => showMsg(ctx, 'Could not save user: ${f.displayMessage}', error: true), (_) => Navigator.pop(ctx));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}
