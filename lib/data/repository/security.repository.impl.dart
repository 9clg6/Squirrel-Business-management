import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/data/local_data_source/security/impl/security.local.data_source.impl.dart';
import 'package:squirrel/data/local_data_source/security/security.local.data_source.dart';
import 'package:squirrel/domain/repositories/security.repository.dart';

part 'security.repository.impl.g.dart';

/// [SecurityRepositoryImpl]
@Riverpod(
  dependencies: <Object>[
    SecurityLocalDataSourceImpl,
  ],
)
class SecurityRepositoryImpl extends _$SecurityRepositoryImpl
    implements SecurityRepository {
  /// Default constructor
  SecurityRepositoryImpl();

  /// Constructor
  /// @param [_localDataSource] local data source
  ///
  SecurityRepositoryImpl._(this._localDataSource);

  late final SecurityLocalDataSource _localDataSource;

  /// Build
  /// @return [Future<SecurityRepositoryImpl>] security repository impl
  ///
  @override
  Future<SecurityRepositoryImpl> build() async {
    return SecurityRepositoryImpl._(
      await ref.watch(securityLocalDataSourceImplProvider.future),
    );
  }

  /// Set the app lock state
  /// @param [isLocked] if the app is locked
  /// @return [Future<void>]
  ///
  @override
  Future<void> setAppLockState({required bool isLocked}) async {
    await _localDataSource.setAppLockState(isLocked: isLocked);
  }

  /// Is the app locked
  /// @return [Future<bool>] if the app is locked
  ///
  @override
  Future<bool> isAppLocked() async {
    return _localDataSource.getAppLockState();
  }

  /// Set the fail count
  /// @param [count] the count
  /// @return [Future<void>]
  ///
  @override
  Future<void> setFailCount(int count) async {
    await _localDataSource.setFailCount(count);
  }

  /// Get the fail count
  /// @return [Future<int>] the fail count
  ///
  @override
  Future<int> getFailCount() async {
    return _localDataSource.getFailCount();
  }

  /// Set the last check success
  /// @param [date] the date
  /// @return [Future<void>]
  ///
  @override
  Future<void> setLastCheckSuccess(String date) async {
    await _localDataSource.setLastCheckSuccess(date);
  }

  @override
  Future<DateTime> getLastCheckSuccess() async {
    return _localDataSource.getLastCheckSuccess();
  }

  @override
  Future<void> setLastKnownTime(DateTime date) async {
    await _localDataSource.setLastKnownTime(date.toIso8601String());
  }

  @override
  Future<DateTime> getLastKnownTime() async {
    final String? lastKnownTime = await _localDataSource.getLastKnownTime();

    if (lastKnownTime == null) return DateTime.now();

    return DateTime.tryParse(lastKnownTime) ?? DateTime.now();
  }
}
