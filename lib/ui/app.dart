import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/foundation/router/custom_app_router.dart';
import 'package:squirrel/foundation/theming/theme.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/blocking_screen/block_overlay.screen.dart';

/// The main app widget.
class App extends ConsumerWidget {
  /// Constructor
  /// @param [key] key
  ///
  const App({super.key});

  /// Builds the app widget.
  /// @param [context] context
  /// @return [Widget] widget of the app widget
  ///
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = createTextTheme();
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: theme.light(),
      locale: context.locale,
      builder: (_, Widget? child) => BlockOverlayScreen(child: child!),
    );
  }
}
