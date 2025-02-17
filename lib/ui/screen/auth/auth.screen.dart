import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:init/ui/screen/auth/auth.view_model.dart';
import 'package:init/ui/widgets/help_text.dart';
import 'package:init/ui/widgets/text_variant.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLoading = false;

  final _licenseKeyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextVariant(
              'Connexion',
              variantType: TextVariantType.displaySmall,
            ),
            const Gap(20),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre numéro de compte';
                  }
                  return null;
                },
                controller: _licenseKeyController,
                decoration: const InputDecoration(
                  hintText: 'Entrez votre numéro de compte',
                ),
              ),
            ),
            const Gap(20),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() => _isLoading = true);
                  ref
                      .read(authProvider.notifier)
                      .login(_licenseKeyController.text);
                  setState(() => _isLoading = false);
                }
              },
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : const Text('Connexion'),
            ),
            const Gap(42),
            const HelpText(
              text:
                  "Si vous avez perdu votre clé, contactez votre fournisseur.",
            ),
          ],
        ),
      ),
    );
  }
}
