import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/provider/request_service.provider.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/state/request.state.dart';
import 'package:squirrel/foundation/theming/theme.dart';
import 'package:squirrel/foundation/utils/logger.util.dart';
import 'package:squirrel/foundation/utils/util.dart';
import 'package:squirrel/ui/screen/auth/auth.screen.dart';
import 'package:squirrel/ui/screen/clients/clients.screen.dart';
import 'package:squirrel/ui/screen/history/history.screen.dart';
import 'package:squirrel/ui/screen/main/index.screen.dart';
import 'package:squirrel/ui/screen/order_details/order_details.screen.dart';
import 'package:squirrel/ui/screen/planner/planner.screen.dart';
import 'package:squirrel/ui/screen/request/request.screen.dart';
import 'package:squirrel/ui/screen/stats/stats.screen.dart';
import 'package:squirrel/ui/screen/todo/todo.screen.dart';
import 'package:squirrel/ui/widgets/custom_app_bar.dart';
import 'package:squirrel/ui/widgets/custom_side_bar.dart';

/// The main app widget.
class App extends StatefulWidget {
  /// Constructor
  /// @param [key] key
  ///
  const App({super.key});

  /// Creates the state of the app widget.
  /// @return [State<App>] state of the app widget
  ///
  @override
  State<App> createState() => _AppState();
}

/// The state of the app widget.
///
class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
  }

  /// Builds the app widget.
  /// @param [context] context
  /// @return [Widget] widget of the app widget
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
              routerConfig: _appRouter(),
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

  GoRouter _appRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey:
          injector.get<GlobalKey<NavigatorState>>(instanceName: 'root'),
      initialLocation: '/main',
      redirect: _authRedirect,
      routes: [
        // Route d'authentification
        GoRoute(
          path: '/auth',
          name: 'auth',
          builder: (context, state) => const AuthScreen(),
        ),

        // Routes protégées
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            final bool isAuthRoute = state.uri.toString() == '/auth';

            return Consumer(
              builder: (context, ref, child) {
                final RequestState requestState =
                    ref.watch(requestServiceNotifierProvider);

                return Scaffold(
                  appBar: !isAuthRoute ? const CustomAppBar() : null,
                  backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                  body: Row(
                    children: [
                      if (!isAuthRoute)
                        CustomSideBar(
                          navigationShell: navigationShell,
                        ),
                      Expanded(
                        flex: requestState.isRequestShow ? 2 : 1,
                        child: navigationShell,
                      ),
                      if (requestState.isRequestShow)
                        const Expanded(
                          flex: 1,
                          child: RequestScreen(),
                        ),
                    ],
                  ),
                );
              },
            );
          },
          branches: [
            // Branche 0 - Accueil
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/main',
                  name: 'main',
                  builder: (context, state) => const MainScreen(),
                  routes: [
                    GoRoute(
                      path: 'order-details/:orderId',
                      name: 'order-details',
                      builder: (context, state) => OrderDetailsScreen(
                        order: state.extra! as Order,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Branche 1 - Todo
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/todo',
                  name: 'todo',
                  builder: (context, state) => const TodoScreen(),
                ),
              ],
            ),
            // Branche 2 - Stats
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/stats',
                  name: 'stats',
                  builder: (context, state) => const StatsScreen(),
                ),
              ],
            ),
            // Branche 3 - Planner
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/planner',
                  name: 'planner',
                  builder: (context, state) => const PlannerScreen(),
                ),
              ],
            ),
            // Branche 4 - Clients
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/clients',
                  name: 'clients',
                  builder: (context, state) => const ClientsScreen(),
                ),
              ],
            ),
            // Branche 5 - History
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/history',
                  name: 'history',
                  builder: (context, state) => const HistoryScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String? _authRedirect(BuildContext context, GoRouterState state) {
    bool isAuthenticated = false;

    try {
      // Vérifier si AuthService est déjà enregistré
      if (injector.isRegistered<AuthService>()) {
        isAuthenticated = injector<AuthService>().authState.isUserAuthenticated;
        logInfo(
            'AuthService trouvé, état d\'authentification: $isAuthenticated');
      } else {
        logInfo(
            'AuthService non encore enregistré, redirection vers l\'authentification');
        // Si AuthService n'est pas encore enregistré, considérer l'utilisateur comme non authentifié
        isAuthenticated = false;
      }
    } catch (e) {
      logException(e, StackTrace.current,
          'Erreur lors de la vérification de l\'authentification');
      // En cas d'erreur, considérer l'utilisateur comme non authentifié
      isAuthenticated = false;
    }

    final bool isAuthRoute = state.matchedLocation == '/auth';

    if (!isAuthenticated) {
      if (isAuthRoute) return null;

      return '/auth';
    }

    if (isAuthenticated && isAuthRoute) {
      return '/main';
    }
    return null;
  }
}
