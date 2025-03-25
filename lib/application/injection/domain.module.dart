import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:squirrel/application/env/env.dart';
import 'package:squirrel/domain/service/dialog.service.dart';
import 'package:squirrel/domain/service/navigator.service.dart';

/// Domain module
@module
abstract class DomainModule {
  /// Provide the shellNavigatorKey
  /// @return [GlobalKey<NavigatorState>] navigator key
  ///
  @singleton
  GlobalKey<NavigatorState> provideShellNavigatorKey() =>
      GlobalKey<NavigatorState>();

  /// Injector
  @preResolve
  Future<EnvService> envService() => EnvService.injector();

  /// Allow to inject [DialogService]
  /// @param [navigatorKey] navigator key
  /// @return [DialogService] dialog service
  ///
  @singleton
  DialogService dialogService(
    GlobalKey<NavigatorState> navigatorKey,
  ) =>
      DialogService(navigatorKey);

  /// Allow to inject [NavigatorService]
  /// @param [navigatorKey] navigator key
  /// @return [NavigatorService] navigator service
  ///
  @singleton
  NavigatorService navigatorService(
    GlobalKey<NavigatorState> navigatorKey,
  ) =>
      NavigatorService(navigatorKey);
}
