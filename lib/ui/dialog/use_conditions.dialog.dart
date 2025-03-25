import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Use conditions dialog
class UseConditionsDialog extends StatelessWidget {
  /// Constructor
  /// @param [key] key
  ///
  const UseConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextVariant(
        LocaleKeys.useConditions.tr(),
        variantType: TextVariantType.titleLarge,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 62,
          vertical: 40,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextVariant(
                    LocaleKeys.useConditions1.tr(),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(20),
                  TextVariant(
                    LocaleKeys.useConditions2.tr(),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(20),
                  TextVariant(
                    LocaleKeys.useConditions3.tr(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const Gap(150),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextVariant(
                    LocaleKeys.useConditions4.tr(),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(20),
                  TextVariant(
                    LocaleKeys.useConditions5.tr(),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(20),
                  TextVariant(
                    LocaleKeys.useConditions6.tr(),
                    textAlign: TextAlign.start,
                  ),
                  const Gap(20),
                  TextVariant(
                    LocaleKeys.useConditions7.tr(),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: _CountdownTimer(
            onCountdownComplete: () {},
          ),
        ),
      ],
    );
  }
}

class _CountdownTimer extends StatefulWidget {

  const _CountdownTimer({
    required this.onCountdownComplete,
  });
  final VoidCallback onCountdownComplete;

  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  late final ValueNotifier<int> _countdown;
  bool _isCountdownComplete = false;

  @override
  void initState() {
    super.initState();
    _countdown = ValueNotifier<int>(kDebugMode ? 5 : 30);
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (_countdown.value > 0) {
        _countdown.value--;
        return true;
      }
      setState(() => _isCountdownComplete = true);
      widget.onCountdownComplete();
      return false;
    });
  }

  @override
  void dispose() {
    _countdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ValueListenableBuilder<int>(
          valueListenable: _countdown,
          builder: (BuildContext context, int value, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isCountdownComplete) ...<Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        value: value / 30,
                        backgroundColor: Colors.grey[300],
                        strokeAlign: -2,
                      ),
                      const Gap(16),
                      Center(
                        child: TextVariant(
                          value.toString(),
                          variantType: TextVariantType.titleMedium,
                        ),
                      ),
                      const Gap(16),
                      const TextVariant(
                        'Veuillez patienter avant de pouvoir accepter',
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
        if (_isCountdownComplete)
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => context.pop(true),
            child: const TextVariant(
              "J'accepte",
            ),
          ),
      ],
    );
  }
}
