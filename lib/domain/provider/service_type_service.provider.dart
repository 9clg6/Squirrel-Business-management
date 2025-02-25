// ignore_for_file: avoid_public_notifier_properties
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/business_type.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';

part 'service_type_service.provider.g.dart';

/// [BusinessTypeServiceNotifier]
@Riverpod(keepAlive: true)
class BusinessTypeServiceNotifier extends _$BusinessTypeServiceNotifier {
  /// Service
  late final BusinessTypeService service;

  /// Build
  ///
  @override
  BusinessTypeState build() {
    service = injector.get<BusinessTypeService>();

    service.addListener(
      (s) {
        state = BusinessTypeState.initial().copyWith(
          businessType: s.businessType,
        );
      },
    );

    return service.businessTypeState;
  }

  /// Get service type wording
  /// @param [key] key of the translation
  /// @return Associated and corresponding translation for associated service type
  ///
  String getServiceTypeWording(
    String key, {
    required BusinessTypeState type,
  }) {
    switch (type.businessType) {
      case BusinessType.service:
        return _getServiceTypeWordingForService(key);
      case BusinessType.shop:
        return _getServiceTypeWordingForShop(key);
    }
  }

  /// Get service type wording for service
  /// @param [key] key of the translation
  /// @return Associated and corresponding translation for service
  ///
  String _getServiceTypeWordingForService(String key) {
    switch (key) {
      case "xName":
        return LocaleKeys.shopName.tr();
      case "bestX":
        return LocaleKeys.bestShops.tr();
      case "x":
        return LocaleKeys.shop.tr();
      default:
        return "";
    }
  }

  /// Get service type wording for shop
  /// @param [key] key of the translation
  /// @return Associated and corresponding translation for shop
  ///
  String _getServiceTypeWordingForShop(String key) {
    switch (key) {
      case "xName":
        return LocaleKeys.productName.tr();
      case "bestX":
        return LocaleKeys.bestProducts.tr();
      case "x":
        return LocaleKeys.product.tr();
      default:
        return "";
    }
  }

  /// Invert service type
  ///
  void invertServiceType() {
    service.invertServiceType();
  }
}
