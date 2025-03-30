import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Screen to display a blocking overlay
class BlockOverlayScreen extends ConsumerWidget {
  /// Constructor
  /// @param [key] key
  ///
  const BlockOverlayScreen({
    required this.child,
    super.key,
  });

  /// Child
  final Widget child;

  /// Builds the screen
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final AsyncValue<AuthState> state = ref.watch(authServiceProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            child,
            switch (state) {
              AsyncData<AuthState>(:final AuthState value) => value.isAppLocked
                  ? Positioned.fill(
                      child: ColoredBox(
                        color: colorScheme.primary,
                        child: Center(
                          child: TextVariant(
                            LocaleKeys.appLockedMessage.tr(),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              _ => const SizedBox.shrink(),
            },
          ],
        ),
      ),
    );
  }
}
