// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details.view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderDetailsViewModelHash() =>
    r'059748f52dbe13355adef26660ecc5c7eb185599';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$OrderDetailsViewModel
    extends BuildlessNotifier<OrderDetailsScreenState> {
  late final Order o;

  OrderDetailsScreenState build(
    Order o,
  );
}

/// [OrderDetailsViewModel]
///
/// Copied from [OrderDetailsViewModel].
@ProviderFor(OrderDetailsViewModel)
const orderDetailsViewModelProvider = OrderDetailsViewModelFamily();

/// [OrderDetailsViewModel]
///
/// Copied from [OrderDetailsViewModel].
class OrderDetailsViewModelFamily extends Family<OrderDetailsScreenState> {
  /// [OrderDetailsViewModel]
  ///
  /// Copied from [OrderDetailsViewModel].
  const OrderDetailsViewModelFamily();

  /// [OrderDetailsViewModel]
  ///
  /// Copied from [OrderDetailsViewModel].
  OrderDetailsViewModelProvider call(
    Order o,
  ) {
    return OrderDetailsViewModelProvider(
      o,
    );
  }

  @override
  OrderDetailsViewModelProvider getProviderOverride(
    covariant OrderDetailsViewModelProvider provider,
  ) {
    return call(
      provider.o,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderDetailsViewModelProvider';
}

/// [OrderDetailsViewModel]
///
/// Copied from [OrderDetailsViewModel].
class OrderDetailsViewModelProvider extends NotifierProviderImpl<
    OrderDetailsViewModel, OrderDetailsScreenState> {
  /// [OrderDetailsViewModel]
  ///
  /// Copied from [OrderDetailsViewModel].
  OrderDetailsViewModelProvider(
    Order o,
  ) : this._internal(
          () => OrderDetailsViewModel()..o = o,
          from: orderDetailsViewModelProvider,
          name: r'orderDetailsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderDetailsViewModelHash,
          dependencies: OrderDetailsViewModelFamily._dependencies,
          allTransitiveDependencies:
              OrderDetailsViewModelFamily._allTransitiveDependencies,
          o: o,
        );

  OrderDetailsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.o,
  }) : super.internal();

  final Order o;

  @override
  OrderDetailsScreenState runNotifierBuild(
    covariant OrderDetailsViewModel notifier,
  ) {
    return notifier.build(
      o,
    );
  }

  @override
  Override overrideWith(OrderDetailsViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderDetailsViewModelProvider._internal(
        () => create()..o = o,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        o: o,
      ),
    );
  }

  @override
  NotifierProviderElement<OrderDetailsViewModel, OrderDetailsScreenState>
      createElement() {
    return _OrderDetailsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDetailsViewModelProvider && other.o == o;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, o.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderDetailsViewModelRef on NotifierProviderRef<OrderDetailsScreenState> {
  /// The parameter `o` of this provider.
  Order get o;
}

class _OrderDetailsViewModelProviderElement extends NotifierProviderElement<
    OrderDetailsViewModel,
    OrderDetailsScreenState> with OrderDetailsViewModelRef {
  _OrderDetailsViewModelProviderElement(super.provider);

  @override
  Order get o => (origin as OrderDetailsViewModelProvider).o;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
