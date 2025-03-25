import 'package:collection/collection.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/entities/action.entity.dart';
import 'package:squirrel/domain/entities/client.entity.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';
import 'package:squirrel/foundation/enums/priority.enum.dart';
import 'package:uuid/uuid.dart';

part 'order.entity.g.dart';

/// [Order] entity
@CopyWith()
@JsonSerializable()
class Order with EquatableMixin, SerializableMixin {
  /// Constructor
  /// @param id: Id of the order
  /// @param client: Client of the order
  /// @param clientName: Name of the client
  /// @param sponsor: Sponsor of the order
  /// @param intermediaryContact: Intermediary contact of the order
  /// @param internalProcessingFee: Internal processing fee of the order
  /// @param trackId: Track id of the order
  /// @param startDate: Start date of the order
  /// @param estimatedDuration: Estimated duration of the order
  /// @param shopName: Shop name of the order
  /// @param price: Price of the order
  /// @param commissionRatio: Commission ratio of the order
  /// @param commission: Commission of the order
  /// @param status: Status of the order
  /// @param method: Method of the order
  /// @param note: Note of the order
  /// @param actions: Actions of the order
  /// @param priority: Priority of the order
  ///
  Order({
    required this.client,
    required this.clientName,
    required this.intermediaryContact,
    required this.internalProcessingFee,
    required this.trackId,
    required this.startDate,
    required this.estimatedDuration,
    required this.shopName,
    required this.price,
    required this.commission,
    required this.status,
    required this.method,
    String? id,
    this.sponsor,
    this.commissionRatio,
    this.note,
    List<OrderAction>? actions,
    this.priority = Priority.normal,
  })  : _actions = actions,
        id = id ?? const Uuid().v4();

  /// Empty order
  ///
  factory Order.empty() => Order(
        client: null,
        clientName: '',
        intermediaryContact: '',
        internalProcessingFee: 0,
        trackId: '',
        startDate: DateTime.now(),
        estimatedDuration: Duration.zero,
        shopName: '',
        price: 0,
        commissionRatio: 0,
        commission: 0,
        status: OrderStatus.pending,
        method: '',
        actions: <OrderAction>[],
        note: '',
      );

  /// From json
  /// @param [json] json
  /// @return [Order] order
  ///
  @override
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// Id
  final String id;

  /// Client
  final Client? client;

  /// Client name
  final String clientName;

  /// Sponsor
  final String? sponsor;

  /// Intermediary contact
  final String intermediaryContact;

  /// Internal processing fee
  final double internalProcessingFee;

  /// Track id
  final String trackId;

  /// Start date
  final DateTime startDate;

  /// Estimated duration
  final Duration estimatedDuration;

  /// Shop name
  final String shopName;

  /// Price
  final double price;

  /// Commission ratio
  final double? commissionRatio;

  /// Commission
  final double commission;

  /// Status
  final OrderStatus status;

  /// Method
  final String method;

  /// Note
  final String? note;

  /// Priority
  final Priority priority;

  /// Actions
  final List<OrderAction>? _actions;

  /// Actions
  List<OrderAction> get actions => (_actions ?? <OrderAction>[])
    ..sort((OrderAction a, OrderAction b) => b.date.compareTo(a.date));

  /// Margin
  ///
  double get margin => commission - internalProcessingFee;

  /// End date
  DateTime? get endDate => startDate.add(estimatedDuration);

  /// Next action
  ///
  OrderAction? get nextAction => actions
      .firstWhereOrNull((OrderAction a) => a.date.isAfter(DateTime.now()));

  /// Next action date
  ///
  DateTime? get nextActionDate => actions.isNotEmpty
      ? nextAction != null
          ? nextAction!.date
          : endDate
      : endDate;

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => <Object?>[
        id,
        client,
        clientName,
        sponsor,
        intermediaryContact,
        startDate,
        estimatedDuration,
        note,
        actions,
        status,
        method,
        priority,
        internalProcessingFee,
        trackId,
        shopName,
        price,
        commissionRatio,
        commission,
        margin,
        endDate,
        nextActionDate,
      ];
}
