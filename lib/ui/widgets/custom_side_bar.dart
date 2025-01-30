import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSideBar extends StatelessWidget {
  const CustomSideBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SidebarX(
        controller: SidebarXController(
          selectedIndex: navigationShell.currentIndex,
        ),
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: Theme.of(context).colorScheme.surface,
          textStyle: TextStyle(color: Colors.white.withValues(alpha: .7)),
          selectedTextStyle: const TextStyle(color: Colors.white),
          hoverTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.surface),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .28),
                blurRadius: 30,
              )
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white.withValues(alpha: .7),
            size: 20,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
        ),
        extendedTheme: SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        headerBuilder: (context, extended) {
          return const SizedBox(
            height: 40,
          ); // Pour éviter le chevauchement
        },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Accueil',
            onTap: () {
              if (navigationShell.currentIndex == 0) {
                context.goNamed('main');
              } else {
                navigationShell.goBranch(0);
              }
            },
          ),
          SidebarXItem(
            icon: Icons.list_alt_outlined,
            label: 'Todo liste',
            onTap: () {
              if (navigationShell.currentIndex == 1) {
                context.goNamed('todo');
              } else {
                navigationShell.goBranch(1);
              }
            },
          ),
          SidebarXItem(
            icon: Icons.bar_chart,
            label: 'Statistiques',
            onTap: () {
              if (navigationShell.currentIndex == 2) {
                context.goNamed('stats');
              } else {
                navigationShell.goBranch(2);
              }
            },
          ),
          SidebarXItem(
            icon: Icons.calendar_month_outlined,
            label: 'Planification',
            onTap: () {
              if (navigationShell.currentIndex == 3) {
                context.goNamed('planner');
              } else {
                navigationShell.goBranch(3);
              }
            },
          ),
          SidebarXItem(
            icon: Icons.people_alt_outlined,
            label: 'Clients',
            onTap: () => navigationShell.goBranch(4),
          ),
          SidebarXItem(
            icon: Icons.history,
            label: 'Historique',
            onTap: () => navigationShell.goBranch(5),
          ),
        ],
      ),
    );
  }
}
