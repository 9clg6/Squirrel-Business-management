import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/screen/auth/auth.view_model.dart';
import 'package:squirrel/ui/screen/auth/auth.view_state.dart';
import 'package:squirrel/ui/widgets/help_text.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// [AuthScreen]
class AuthScreen extends ConsumerStatefulWidget {
  /// Constructor
  /// @param [key] key
  ///
  const AuthScreen({super.key});

  /// Create state
  /// @return [ConsumerState<ConsumerStatefulWidget>] state
  ///
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

/// [AuthScreen] state
class _AuthScreenState extends ConsumerState<AuthScreen> {
  final TextEditingController _licenseKeyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Build
  /// @param [context] context
  /// @return [Widget] widget
  ///
  @override
  Widget build(BuildContext context) {
    ref.watch(authServiceProvider);
    final AuthScreenState authState = ref.watch(authProvider);

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
            children: <Widget>[
              TextVariant(
                LocaleKeys.login.tr(),
                variantType: TextVariantType.displaySmall,
              ),
              const Gap(20),
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.pleaseEnterYourAccountNumber.tr();
                    }
                    return null;
                  },
                  controller: _licenseKeyController,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.pleaseEnterYourAccountNumber.tr(),
                  ),
                ),
              ),
              const Gap(20),
              if (authState.loading)
                CircularProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  strokeAlign: -2,
                )
              else
                FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .watch(authProvider.notifier)
                          .login(_licenseKeyController.text);
                    }
                  },
                  child: TextVariant(
                    LocaleKeys.login.tr(),
                  ),
                ),
              const Gap(42),
              HelpText(
                text: LocaleKeys.ifYouHaveLostYourKey.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
