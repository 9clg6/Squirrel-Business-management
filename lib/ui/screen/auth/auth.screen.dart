import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/ui/screen/auth/auth.view_model.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.55,
          ),
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
              _isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      strokeWidth: 4,
                      strokeAlign: -2,
                    )
                  : FilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => _isLoading = true);
                          await ref
                              .read(authProvider.notifier)
                              .login(_licenseKeyController.text);
                          setState(() => _isLoading = false);
                        }
                      },
                      child: const Text('Connexion'),
                    ),
              const Gap(42),
              const HelpText(
                text:
                    "Si vous avez perdu votre clé, contactez votre fournisseur.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
