import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/provider/request_service.provider.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/state/request.state.dart';
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

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

String? _authRedirect(BuildContext context, GoRouterState state) {
  final bool isAuthenticated = injector<AuthService>().isUserAuthenticated;
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

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: rootNavigatorKey,
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
            final RequestState requestState = ref.watch(requestServiceNotifierProvider);

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
