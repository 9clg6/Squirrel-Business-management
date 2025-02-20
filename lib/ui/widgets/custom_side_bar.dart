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
      child: Align(
        alignment: Alignment.topCenter,
        child: SidebarX(
          controller: controller,
          showToggleButton: true,
          theme: SidebarXTheme(
            margin: const EdgeInsets.only(
              bottom: 10,
              right: 10,
              left: 10,
            ),
            width: 60,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .2),
                width: 1,
              ),
            ),
            hoverColor: colorScheme.primaryContainer,
            hoverTextStyle: TextStyle(
              color: colorScheme.onSurface,
            ),
            textStyle: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: .5),
            ),
            selectedIconTheme: IconThemeData(
              color: colorScheme.onSurface,
            ),
            selectedItemPadding: const EdgeInsets.all(10),
            selectedItemTextPadding: const EdgeInsets.only(left: 12),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colorScheme.primary,
            ),
            itemTextPadding: const EdgeInsets.only(left: 8),
            itemPadding: const EdgeInsets.all(10),
            itemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.surface.withValues(alpha: .5),
              ),
            ),
          ),
          extendedTheme: SidebarXTheme(
            width: 200,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: .2),
                width: 1,
              ),
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
          items: [
            SidebarXItem(
              label: 'Accueil',
              icon: Icons.home,
              onTap: () {
                if (widget.navigationShell.currentIndex == 0) {
                  context.goNamed('main');
                } else {
                  widget.navigationShell.goBranch(0);
                }
              },
            ),
            SidebarXItem(
              icon: Icons.list_alt_outlined,
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
              icon: Icons.bar_chart,
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
              icon: Icons.calendar_month_outlined,
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
              icon: Icons.people_alt_outlined,
              label: 'Clients',
              onTap: () => widget.navigationShell.goBranch(4),
            ),
            SidebarXItem(
              icon: Icons.history,
              label: 'Historique',
              onTap: () => widget.navigationShell.goBranch(5),
            ),
          ],
        ),
      ),
    );
  }
}
