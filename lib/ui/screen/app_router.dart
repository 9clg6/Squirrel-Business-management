import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:init/domain/entities/order.entity.dart';
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

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: parentNavigatorKey,
  routes: [
    StatefulShellRoute(
      parentNavigatorKey: parentNavigatorKey,
      builder: (context, state, navigationShell) => navigationShell,
      navigatorContainerBuilder: (
        BuildContext context,
        StatefulNavigationShell navigationShell,
        List<Widget> children,
      ) {
        if (children.isEmpty) {
          return const SizedBox();
        }
        return Scaffold(
          appBar: const CustomAppBar(),
          body: Row(
            children: [
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
              builder: (_, state) => const MainScreen(),
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
              builder: (_, state) => const TodoScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              name: 'stats',
              builder: (_, state) => const StatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/planner',
              name: 'planner',
              builder: (_, state) => const PlannerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/clients',
              name: 'clients',
              builder: (_, state) => const ClientsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              name: 'history',
              builder: (_, state) => const HistoryScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
