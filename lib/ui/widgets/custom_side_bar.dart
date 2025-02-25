import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';

/// Custom side bar
class CustomSideBar extends StatefulWidget {
  /// Constructor
  /// @param [key] key
  /// @param [navigationShell] navigation shell
  /// 
  const CustomSideBar({
    super.key,
    required this.navigationShell,
  });

  /// Navigation shell
  final StatefulNavigationShell navigationShell;

  /// Create the state
  /// @return [State<CustomSideBar>] state of the custom side bar
  /// 
  @override
  State<CustomSideBar> createState() => _CustomSideBarState();
}

/// State of the custom side bar
class _CustomSideBarState extends State<CustomSideBar> {
  /// Controller
  late SidebarXController controller;

  /// Init the state
  /// 
  @override
  void initState() {
    super.initState();
    controller = SidebarXController(
      selectedIndex: widget.navigationShell.currentIndex,
      extended: true,
    );
  }

  /// Build the side bar
  /// @param [context] context
  /// @return [Widget] widget of the side bar
  /// 
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
              label: LocaleKeys.home.tr(),
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
              label: LocaleKeys.todoList.tr(),
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
              label: LocaleKeys.stats.tr(),
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
              label: LocaleKeys.planification.tr(),
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
              label: LocaleKeys.clients.tr(),
              onTap: () => widget.navigationShell.goBranch(4),
            ),
            SidebarXItem(
              icon: Icons.history,
              label: LocaleKeys.history.tr(),
              onTap: () => widget.navigationShell.goBranch(5),
            ),
          ],
        ),
      ),
    );
  }
}
