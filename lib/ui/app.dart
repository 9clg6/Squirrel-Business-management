import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/state/request.state.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
import 'package:squirrel/foundation/routing/routing_key.dart';
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
import 'package:squirrel/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:squirrel/ui/widgets/custom_side_bar/custom_side_bar.dart';

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
  /// Initializes the state of the app widget.
  ///
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: <SystemUiOverlay>[],
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

    return Builder(
      builder: (BuildContext context) {
        return ProviderScope(
          child: MaterialApp.router(
            routerConfig: _appRouter(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            theme: theme.light(),
            locale: context.locale,
            builder: (_, Widget? child) => child!,
          ),
        );
      },
    );
  }

  /// Initializes the app router.
  /// @return [GoRouter] app router
  ///
  GoRouter _appRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: routingKey,
      initialLocation: RouterEnum.main.path,
      redirect: _authRedirect,
      routes: <RouteBase>[
        GoRoute(
          path: RouterEnum.auth.path,
          name: RouterEnum.auth.name,
          builder: (BuildContext context, GoRouterState state) =>
              const AuthScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell,
          ) {
            final bool isAuthRoute =
                state.uri.toString() == RouterEnum.auth.path;

            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final RequestState requestState =
                    ref.watch(requestServiceProvider);

                return Scaffold(
                  appBar: !isAuthRoute ? const CustomAppBar() : null,
                  backgroundColor: Theme.of(context).colorScheme.surfaceDim,
                  body: Row(
                    children: <Widget>[
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
                          child: RequestScreen(),
                        ),
                    ],
                  ),
                );
              },
            );
          },
          branches: <StatefulShellBranch>[
            // Branche 0 - Accueil
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.main.path,
                  name: RouterEnum.main.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const MainScreen(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: '${RouterEnum.orderDetails.path}/:orderId',
                      name: RouterEnum.orderDetails.name,
                      builder: (BuildContext context, GoRouterState state) =>
                          OrderDetailsScreen(
                        order: state.extra! as Order,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Branche 1 - Todo
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.todo.path,
                  name: RouterEnum.todo.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const TodoScreen(),
                ),
              ],
            ),
            // Branche 2 - Stats
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.stats.path,
                  name: RouterEnum.stats.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const StatsScreen(),
                ),
              ],
            ),
            // Branche 3 - Planner
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.planner.path,
                  name: RouterEnum.planner.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const PlannerScreen(),
                ),
              ],
            ),
            // Branche 4 - Clients
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.clients.path,
                  name: RouterEnum.clients.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const ClientsScreen(),
                ),
              ],
            ),
            // Branche 5 - History
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RouterEnum.history.path,
                  name: RouterEnum.history.name,
                  builder: (BuildContext context, GoRouterState state) =>
                      const HistoryScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Redirects the user to the correct route based
  ///   on their authentication status.
  /// @param [context] context
  /// @param [state] state
  /// @return [String?] redirect route
  ///
  Future<String?> _authRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    // Capture du conteneur et du service d'authentification
    //  avant toute opération asynchrone
    final ProviderContainer container = ProviderScope.containerOf(context);

    // Si le service n'existe pas encore, ne pas rediriger
    if (!container.exists(authServiceProvider)) {
      return null;
    }

    final AsyncValue<AuthState> authService =
        container.read(authServiceProvider);

    // Vérifier si l'état d'authentification est en cours de chargement
    if (authService.isLoading || !authService.hasValue) {
      return null;
    }

    // Si le service n'est pas initialisé, attendre son initialisation
    if (!authService.value!.isInitialized) {
      await container.read(authServiceProvider.notifier).build();
      return null;
    }

    final bool isAuthenticated =
        authService.value?.isUserAuthenticated ?? false;
    final bool isAuthRoute = state.matchedLocation == RouterEnum.auth.path;

    // Si on est sur /auth et pas authentifié, rester sur /auth
    if (!isAuthenticated && isAuthRoute) {
      return null;
    }

    // Si on n'est pas authentifié et pas sur /auth, rediriger vers /auth
    if (!isAuthenticated) {
      return RouterEnum.auth.path;
    }

    // Si on est authentifié et sur /auth, rediriger vers /main
    if (isAuthenticated && isAuthRoute) {
      return RouterEnum.main.path;
    }

    // Si on est authentifié et pas sur /auth, ne pas rediriger
    return null;
  }
}
