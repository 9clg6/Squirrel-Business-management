import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/order.entity.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/service/logger.service.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/domain/state/request.state.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
import 'package:squirrel/foundation/routing/routing_key.dart';
import 'package:squirrel/ui/screen/auth/auth.screen.dart';
import 'package:squirrel/ui/screen/customers/customers.screen.dart';
import 'package:squirrel/ui/screen/history/history.screen.dart';
import 'package:squirrel/ui/screen/main/index.screen.dart';
import 'package:squirrel/ui/screen/order_details/order_details.screen.dart';
import 'package:squirrel/ui/screen/planner/planner.screen.dart';
import 'package:squirrel/ui/screen/request/request.screen.dart';
import 'package:squirrel/ui/screen/stats/stats.screen.dart';
import 'package:squirrel/ui/screen/todo/todo.screen.dart';
import 'package:squirrel/ui/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:squirrel/ui/widgets/custom_side_bar/custom_side_bar.dart';

part 'custom_app_router.g.dart';

/// Custom app router
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    AuthService,
    RequestService,
  ],
)
GoRouter router(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: routingKey,
    initialLocation: RouterEnum.main.path,
    redirect: (_, GoRouterState state) => _authRedirect(ref, state),
    routes: <RouteBase>[
      GoRoute(
        path: RouterEnum.auth.path,
        name: RouterEnum.auth.name,
        builder: (_, __) => const AuthScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          final bool isAuthRoute = state.uri.toString() == RouterEnum.auth.path;

          final RequestState requestState = ref.watch(requestServiceProvider);

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
        branches: <StatefulShellBranch>[
          // Branche 0 - Accueil
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RouterEnum.main.path,
                name: RouterEnum.main.name,
                builder: (_, __) => const MainScreen(),
                routes: <RouteBase>[
                  GoRoute(
                    path: '${RouterEnum.orderDetails.path}/:orderId',
                    name: RouterEnum.orderDetails.name,
                    builder: (_, GoRouterState state) => OrderDetailsScreen(
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
                builder: (_, __) => const TodoScreen(),
              ),
            ],
          ),
          // Branche 2 - Stats
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RouterEnum.stats.path,
                name: RouterEnum.stats.name,
                builder: (_, __) => const StatsScreen(),
              ),
            ],
          ),
          // Branche 3 - Planner
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RouterEnum.planner.path,
                name: RouterEnum.planner.name,
                builder: (_, __) => const PlannerScreen(),
              ),
            ],
          ),
          // Branche 4 - Customers
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RouterEnum.customers.path,
                name: RouterEnum.customers.name,
                builder: (_, __) => const CustomersScreen(),
              ),
            ],
          ),
          // Branche 5 - History
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RouterEnum.history.path,
                name: RouterEnum.history.name,
                builder: (_, __) => const HistoryScreen(),
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
/// @param [ref] ref
/// @param [state] state
/// @return [String?] redirect route
///
Future<String?> _authRedirect(
  Ref ref,
  GoRouterState state,
) async {
  final AuthState authState = await ref.watch(authServiceProvider.future);

  final bool isAuthenticated = authState.isUserAuthenticated;
  final bool isAuthRoute = state.matchedLocation == RouterEnum.auth.path;

  if (!isAuthenticated && isAuthRoute) {
    LoggerService.instance
        .e('[AuthService] 🔐❌ User is not authenticated and is on auth route');
    return null;
  }

  if (!isAuthenticated) {
    LoggerService.instance.e(
      '[AuthService] 🔐❌ User is not authenticated and is not on auth route',
    );
    return RouterEnum.auth.path;
  }

  if (isAuthenticated && isAuthRoute) {
    LoggerService.instance
        .i('[AuthService] 🔐✅ User is authenticated and is on auth route');
    return RouterEnum.main.path;
  }

  return null;
}
