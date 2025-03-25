import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';
import 'package:squirrel/foundation/localizations/localizations.dart';

part 'business_type.service.g.dart';

/// [BusinessTypeService]
@Riverpod(
  dependencies: <Object>[
    HiveSecureStorageService,
  ],
)
class BusinessTypeService extends _$BusinessTypeService {
  /// Key for secure storage
  static const String _businessTypeKey = 'business_type';

  /// Secure storage service
  late final HiveSecureStorageService _storageService;

  bool _isInitialized = false;

  /// Build
  ///
  @override
  Future<BusinessTypeState> build() async {
    if (!_isInitialized) {
      log('🔌 Initializing BusinessTypeService');
      _storageService = ref.watch(hiveSecureStorageServiceProvider.notifier);
      _isInitialized = true;
    }

    final String? businessType = await _storageService.get(_businessTypeKey);

    return BusinessTypeState.initial(
      businessType: BusinessType.values.firstWhere(
        (BusinessType bT) => bT.name == businessType,
        orElse: () => BusinessType.service,
      ),
    );
  }

  /// Invert service type
  /// @return [void] void
  ///
  void invertServiceType() {
    late BusinessType type;
    switch (state.value?.businessType) {
      case BusinessType.service:
        type = BusinessType.shop;
        state = AsyncData<BusinessTypeState>(
          state.value!.copyWith(businessType: BusinessType.shop),
        );
      case BusinessType.shop:
        type = BusinessType.service;
        state = AsyncData<BusinessTypeState>(
          state.value!.copyWith(businessType: BusinessType.service),
        );
      case null:
        throw UnimplementedError();
    }
    _saveBusinessType(type);
  }

  /// Save business type
  /// @param [type] business type
  /// @return [void] void
  ///
  void _saveBusinessType(BusinessType type) {
    _storageService.set(
      _businessTypeKey,
      type.name,
    );
  }

  /// Get service type wording
  /// @param [key] key of the translation
  /// @param [type] business type
  /// @return Associated and corresponding translation 
  ///   for associated service type
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
      case 'xName':
        return LocaleKeys.shopName.tr();
      case 'bestX':
        return LocaleKeys.bestShops.tr();
      case 'x':
        return LocaleKeys.shop.tr();
      default:
        return '';
    }
  }

  /// Get service type wording for shop
  /// @param [key] key of the translation
  /// @return Associated and corresponding translation for shop
  ///
  String _getServiceTypeWordingForShop(String key) {
    switch (key) {
      case 'xName':
        return LocaleKeys.productName.tr();
      case 'bestX':
        return LocaleKeys.bestProducts.tr();
      case 'x':
        return LocaleKeys.product.tr();
      default:
        return '';
    }
  }
}
