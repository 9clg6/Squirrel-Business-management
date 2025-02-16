import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/entities/order.entity.dart';
import 'package:init/domain/service/auth.service.dart';
import 'package:init/ui/screen/auth/auth.screen.dart';
import 'package:init/ui/screen/clients/clients.screen.dart';
import 'package:init/ui/screen/history/history.screen.dart';
import 'package:init/ui/screen/main/index.screen.dart';
import 'package:init/ui/screen/order_details/order_details.screen.dart';
import 'package:init/ui/screen/planner/planner.screen.dart';
import 'package:init/ui/screen/stats/stats.screen.dart';
import 'package:init/ui/screen/todo/todo.screen.dart';
import 'package:init/ui/widgets/custom_app_bar.dart';
import 'package:init/ui/widgets/custom_side_bar.dart';

final GlobalKey<NavigatorState> parentNavigatorKey =
    GlobalKey<NavigatorState>();

String? _authGuard(context, state) {
  final bool isAuthenticated = injector<AuthService>().isUserAuthenticated;
  if (!isAuthenticated) {
    return '/auth';
  }
  return null;
}

bool _checkIfAuthRoute(String location) {
  return location.startsWith('/auth');
}

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: parentNavigatorKey,
  redirect: _authGuard,
  routes: [
    StatefulShellRoute(
      parentNavigatorKey: parentNavigatorKey,
      builder: (_, __, navigationShell) => navigationShell,
      navigatorContainerBuilder: (
        _,
        StatefulNavigationShell navigationShell,
        List<Widget> children,
      ) {
        if (children.isEmpty) {
          return const SizedBox();
        }
        return Scaffold(
          appBar: !_checkIfAuthRoute(
                  navigationShell.shellRouteContext.routerState.matchedLocation)
              ? const CustomAppBar()
              : null,
          body: Row(
            children: [
              if (!_checkIfAuthRoute(navigationShell
                  .shellRouteContext.routerState.matchedLocation))
                CustomSideBar(navigationShell: navigationShell),
              Expanded(child: children[navigationShell.currentIndex]),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'main',
              builder: (_, __) => const MainScreen(),
            ),
            GoRoute(
              path: '/order-details/:orderId',
              name: 'order-details',
              builder: (_, state) => OrderDetailsScreen(
                order: state.extra! as Order,
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/todo',
              name: 'todo',
              builder: (_, __) => const TodoScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/auth',
              name: 'auth',
              builder: (_, __) => const AuthScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              name: 'stats',
              builder: (_, __) => const StatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/planner',
              name: 'planner',
              builder: (_, __) => const PlannerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/clients',
              name: 'clients',
              builder: (_, __) => const ClientsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              name: 'history',
              builder: (_, __) => const HistoryScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
