import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:init/foundation/routing/app_router.dart';
import 'package:init/ui/widgets/text_variant.dart';

class UseConditionsDialog extends StatelessWidget {
  const UseConditionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Conditions d\'utilisation'),
      content: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextVariant(
                "1) Chaque clé de licence est unique, valide 30 jours et utilisable par un seul utilisateur.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "2) Si vous communiquez votre clé de licence à un tiers, la clé sera bannie et ne pourra plus être utilisée. Vous perderez alors l'accès à l'application et ne serez pas remboursé.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "3) Hors mis la vérification de la clé de licence, qui n'est associée à aucune autre donnée, aucune information personnelle n'est collectée. Aucune donnée ne transite par internet.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "4) Si vous perdez accès à votre appareil, nous ne pourrons d'aucune façon vous aider à les récupérer. (cf règle 3)",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "5) Les développeurs de cette application ne sont pas responsables, garants, approbateurs, commanditaires ou autre de l'utilisation ou la finalité de cette application.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "6) Nous n'approuvons aucune activité illégale ou non conforme à la législation en vigueur.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
              _SplitPoint(),
              TextVariant(
                "7) Les développeurs de cette application souhaite correspondre aux besoins de ses utilisateurs. Si vous avez des suggestions, des questions ou des problèmes, veuillez contacter votre fournisseur.",
                variantType: TextVariantType.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      actions: [
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
  final VoidCallback onCountdownComplete;

  const _CountdownTimer({
    required this.onCountdownComplete,
  });

  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  late final ValueNotifier<int> _countdown;
  bool _isCountdownComplete = false;

  @override
  void initState() {
    super.initState();
    _countdown = ValueNotifier<int>(30);
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: _countdown,
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!_isCountdownComplete) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: value / 30,
                        backgroundColor: Colors.grey[300],
                        strokeWidth: 8,
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
                        variantType: TextVariantType.bodyMedium,
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
            onPressed: () => appRouter.pop(true),
            child: const TextVariant(
              'J\'accepte',
              variantType: TextVariantType.bodyMedium,
            ),
          ),
      ],
    );
  }
}

class _SplitPoint extends StatelessWidget {
  const _SplitPoint();

  @override
  Widget build(BuildContext context) {
    return const TextVariant(
      "•",
      variantType: TextVariantType.titleMedium,
      textAlign: TextAlign.center,
    );
  }
}
