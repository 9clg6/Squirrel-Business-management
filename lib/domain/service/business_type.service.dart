import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/service/hive_secure_storage.service.dart';
import 'package:squirrel/domain/state/business_type.state.dart';
import 'package:squirrel/foundation/enums/service_type.enum.dart';

/// [BusinessTypeService]
class BusinessTypeService extends StateNotifier<BusinessTypeState> {
  /// Key for secure storage
  static const String _businessTypeKey = "business_type";

  /// Secure storage service
  final HiveSecureStorageService _storageService;

  /// State of the service
  BusinessTypeState get businessTypeState => state;

  /// Constructor
  ///
  BusinessTypeService._(
    this._storageService,
    BusinessType type,
  ) : super(
          BusinessTypeState.initial().copyWith(businessType: type),
        );

  /// Inject
  /// @param [secureStorageService] Secure storage service
  /// @return [BusinessTypeService] business type service filled with data
  ///
  static Future<BusinessTypeService> inject(
      HiveSecureStorageService secureStorageService) async {
    final String? businessType =
        await secureStorageService.get(_businessTypeKey);

    return BusinessTypeService._(
      secureStorageService,
      BusinessType.values.firstWhere(
        (bT) => bT.name == businessType,
        orElse: () => BusinessType.service,
      ),
    );
  }

  /// Invert service type
  ///
  void invertServiceType() {
    late BusinessType type;
    switch (state.businessType) {
      case BusinessType.service:
        type = BusinessType.shop;
        state = state.copyWith(businessType: type);
        break;
      default:
        type = BusinessType.service;
        state = state.copyWith(businessType: type);
        break;
    }
    _saveBusinessType(type);
  }

  /// Save business type
  /// @param [type] business type
  ///
  void _saveBusinessType(BusinessType type) {
    _storageService.set(
      _businessTypeKey,
      type.name,
    );
  }
}
