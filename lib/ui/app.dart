import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/foundation/routing/app_router.dart';
import 'package:squirrel/foundation/theming/theme.dart';
import 'package:squirrel/foundation/utils/util.dart';

///
/// The main app widget.
///
class App extends StatefulWidget {
  ///
  /// Constructor
  ///
  const App({super.key});

  ///
  /// Creates the state of the app widget.
  ///
  @override
  State<App> createState() => _AppState();
}

///
/// The state of the app widget.
///
class _AppState extends State<App> {
  ///
  /// Builds the app widget.
  ///
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = createTextTheme();
    final MaterialTheme theme = MaterialTheme(textTheme);

    final Brightness brightness =
        View.of(context).platformDispatcher.platformBrightness;

    return Builder(
      builder: (context) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: ProviderScope(
            child: MaterialApp.router(
              routerConfig: appRouter,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              theme:
                  brightness == Brightness.light ? theme.light() : theme.dark(),
              locale: context.locale,
              builder: (_, child) => child!,
            ),
          ),
        );
      },
    );
  }
}
