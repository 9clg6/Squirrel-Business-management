// ignore_for_file: lines_longer_than_80_chars x

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:squirrel/domain/service/import_export.service.dart';
import 'package:squirrel/foundation/enums/router.enum.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';
import 'package:squirrel/foundation/providers/service/dialog.service.provider.dart';
import 'package:squirrel/foundation/providers/service/import_export.provider.dart';
import 'package:squirrel/ui/widgets/text_variant.dart';

/// Custom side bar
class CustomSideBar extends ConsumerStatefulWidget {
  /// Constructor
  /// @param [key] key
  /// @param [navigationShell] navigation shell
  ///
  const CustomSideBar({
    required this.navigationShell,
    super.key,
  });

  /// Navigation shell
  final StatefulNavigationShell navigationShell;

  /// Create the state
  /// @return [State<CustomSideBar>] state of the custom side bar
  ///
  @override
  ConsumerState<CustomSideBar> createState() => _CustomSideBarState();
}

/// State of the custom side bar
class _CustomSideBarState extends ConsumerState<CustomSideBar> {
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const double itemPadding = 10;
    const double borderRadiusInner = 10;
    const double borderRadiusOuter = borderRadiusInner + itemPadding;

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Expanded(
              child: SidebarX(
                controller: controller,
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
                    ),
                  ),
                  hoverColor: colorScheme.secondary,
                  hoverTextStyle: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 12,
                  ),
                  textStyle: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: .5),
                  ),
                  selectedIconTheme: IconThemeData(
                    color: colorScheme.onPrimary,
                  ),
                  selectedTextStyle: TextStyle(
                    color: colorScheme.onPrimary,
                  ),
                  selectedItemPadding: const EdgeInsets.all(itemPadding),
                  selectedItemTextPadding: const EdgeInsets.only(left: 12),
                  selectedItemDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusInner),
                    color: colorScheme.primary,
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: .2),
                    ),
                  ),
                  itemTextPadding: const EdgeInsets.only(left: 8),
                  itemPadding: const EdgeInsets.all(itemPadding),
                  itemDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusInner),
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
                    borderRadius: BorderRadius.circular(borderRadiusOuter),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: .2),
                    ),
                  ),
                  textStyle: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 12,
                  ),
                  selectedTextStyle: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                items: <SidebarXItem>[
                  SidebarXItem(
                    label: LocaleKeys.home.tr(),
                    icon: Icons.home,
                    onTap: () {
                      if (widget.navigationShell.currentIndex == 0) {
                        context.goNamed(RouterEnum.main.name);
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
                        context.goNamed(RouterEnum.todo.name);
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
                        context.goNamed(RouterEnum.stats.name);
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
                        context.goNamed(RouterEnum.planner.name);
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
            Row(
              children: <Widget>[
                StreamBuilder<bool>(
                  stream: controller.extendStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return InkWell(
                      onTap: () =>
                          ref.watch(dialogServiceProvider).showInComingDialog(),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.rocket_launch_rounded,
                              color: colorScheme.onPrimary,
                            ),
                            if (snapshot.data ?? false) ...<Widget>[
                              const Gap(5),
                              TextVariant(
                                LocaleKeys.comingSoon.tr(),
                                color: colorScheme.onPrimary,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Gap(12),
                IconButton(
                  tooltip: 'Exporter les données',
                  onPressed: () =>
                      ref.watch(dialogServiceProvider).showConfirmationDialog(
                    'Exporter les données',
                    'Voulez-vous vraiment exporter les données ?',
                    () {
                      ref
                          .watch(importExportServiceProvider.future)
                          .then((ImportExportService importExportService) {
                        importExportService.exportData();
                      });
                    },
                  ),
                  icon: const Icon(Icons.file_upload),
                ),
                const Gap(12),
                IconButton(
                  tooltip: 'Importer les données',
                  onPressed: () =>
                      ref.watch(dialogServiceProvider).showConfirmationDialog(
                    'Importer les données',
                    'Pour importer les données, merci de choisir le fichier à importer et de saisir la clé de chiffrement',
                    () {
                      ref.watch(importExportServiceProvider.future).then(
                          (ImportExportService importExportService) async {
                        final (FilePickerResult?, String?, bool?)? data =
                            await ref
                                .watch(dialogServiceProvider)
                                .showImportDialog();

                        if (data != null) {
                          await importExportService.importData(
                            file: data.$1,
                            key: data.$2,
                            overrideData: data.$3,
                          );
                        }
                      });
                    },
                  ),
                  icon: const Icon(Icons.file_download),
                ),
              ],
            ),
            const Gap(12),
          ],
        ),
      ),
    );
  }
}
