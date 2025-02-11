import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';

class CustomSideBar extends StatefulWidget {
  const CustomSideBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  late SidebarXController controller;

  @override
  void initState() {
    super.initState();
    controller = SidebarXController(
      selectedIndex: widget.navigationShell.currentIndex,
      extended: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: SidebarX(
        controller: controller,
        showToggleButton: true,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          width: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          hoverColor: Theme.of(context).colorScheme.surface,
          textStyle: TextStyle(color: Colors.white.withValues(alpha: .5)),
          selectedTextStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          itemTextPadding: const EdgeInsets.only(left: 8),
          selectedItemTextPadding: const EdgeInsets.only(left: 12),
          itemPadding: const EdgeInsets.all(10),
          selectedItemPadding: const EdgeInsets.all(10),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorScheme.surface.withValues(alpha: .5),
            ),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: .2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .28),
                blurRadius: 30,
              )
            ],
          ),
        ),
        extendedTheme: SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: colorScheme.surface,
          ),
          textStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 12,
          ),
          selectedTextStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w600,
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
              return const Tooltip(
                message: 'Accueil',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.home,
                  size: 20,
                ),
              );
            },
            onTap: () {
              if (widget.navigationShell.currentIndex == 0) {
                context.goNamed('main');
              } else {
                widget.navigationShell.goBranch(0);
              }
            },
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return const Tooltip(
                message: 'Todo liste',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.list_alt_outlined,
                  size: 20,
                ),
              );
            },
            label: 'Todo liste',
            onTap: () {
              if (widget.navigationShell.currentIndex == 1) {
                context.goNamed('todo');
              } else {
                widget.navigationShell.goBranch(1);
              }
            },
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return const Tooltip(
                message: 'Statistiques',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.bar_chart,
                  size: 20,
                ),
              );
            },
            label: 'Statistiques',
            onTap: () {
              if (widget.navigationShell.currentIndex == 2) {
                context.goNamed('stats');
              } else {
                widget.navigationShell.goBranch(2);
              }
            },
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return const Tooltip(
                message: 'Planification',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
              );
            },
            label: 'Planification',
            onTap: () {
              if (widget.navigationShell.currentIndex == 3) {
                context.goNamed('planner');
              } else {
                widget.navigationShell.goBranch(3);
              }
            },
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return const Tooltip(
                message: 'Clients',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.people_alt_outlined,
                  size: 20,
                ),
              );
            },
            label: 'Clients',
            onTap: () => widget.navigationShell.goBranch(4),
          ),
          SidebarXItem(
            iconBuilder: (selected, hovered) {
              return const Tooltip(
                message: 'Historique',
                exitDuration: Duration(milliseconds: 50),
                child: Icon(
                  Icons.history,
                  size: 20,
                ),
              );
            },
            label: 'Historique',
            onTap: () => widget.navigationShell.goBranch(5),
          ),
        ],
      ),
    );
  }
}
