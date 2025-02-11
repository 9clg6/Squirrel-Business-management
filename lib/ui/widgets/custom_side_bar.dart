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
    final colorSheme = Theme.of(context).colorScheme;

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
          itemPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          selectedItemPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).colorScheme.surface),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
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
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        headerBuilder: (context, extended) {
          return const SizedBox(
            height: 10,
          ); // Pour éviter le chevauchement
        },
        items: [
          SidebarXItem(
            label: 'Accueil',
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Accueil',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.home,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
            onTap: () {
              if (navigationShell.currentIndex == 0) {
                context.goNamed('main');
              } else {
                navigationShell.goBranch(0);
              }
            },
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Todo liste',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.list_alt_outlined,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
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
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Statistiques',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.bar_chart,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
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
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Planification',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
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
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Clients',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.people_alt_outlined,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
            label: 'Clients',
            onTap: () => navigationShell.goBranch(4),
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return Tooltip(
                message: 'Historique',
                exitDuration: const Duration(milliseconds: 50),
                child: Icon(
                  Icons.history,
                  color: selected
                      ? colorSheme.onSurface
                      : colorSheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              );
            },
            label: 'Historique',
            onTap: () => navigationShell.goBranch(5),
          ),
        ],
      ),
    );
  }
}
