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
///
@CopyWith()
@JsonSerializable()
class Order with EquatableMixin, SerializableMixin {
  final String id;
  final Client? client;
  final String clientName;
  final String? sponsor;
  final String intermediaryContact;
  final double internalProcessingFee;
  final String trackId;
  final DateTime startDate;
  final Duration estimatedDuration;
  final String shopName;
  final double price;
  final double? commissionRatio;
  final double commission;
  final OrderStatus status;
  final String method;
  final String? note;
  final Priority priority;
  final List<OrderAction>? _actions;

  /// Actions
  ///
  List<OrderAction> get actions =>
      (_actions ?? [])..sort((a, b) => b.date.compareTo(a.date));

  /// Margin
  ///
  double get margin => commission - internalProcessingFee;

  /// End date
  DateTime? get endDate => startDate.add(estimatedDuration);

  /// Next action
  ///
  OrderAction? get nextAction =>
      actions.firstWhereOrNull((a) => a.date.isAfter(DateTime.now()));

  /// Next action date
  ///
  DateTime? get nextActionDate => actions.isNotEmpty
      ? nextAction != null
          ? nextAction!.date
          : endDate
      : endDate;

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
    String? id,
    required this.client,
    required this.clientName,
    this.sponsor,
    required this.intermediaryContact,
    required this.internalProcessingFee,
    required this.trackId,
    required this.startDate,
    required this.estimatedDuration,
    required this.shopName,
    required this.price,
    this.commissionRatio,
    required this.commission,
    required this.status,
    required this.method,
    this.note,
    List<OrderAction>? actions,
    this.priority = Priority.normal,
  })  : _actions = actions,
        id = id ?? const Uuid().v4();

  /// Empty order
  ///
  factory Order.empty() => Order(
        client: null,
        clientName: "",
        intermediaryContact: '',
        internalProcessingFee: 0,
        trackId: '',
        startDate: DateTime.now(),
        estimatedDuration: const Duration(days: 0),
        shopName: '',
        price: 0,
        commissionRatio: 0,
        commission: 0,
        status: OrderStatus.pending,
        method: '',
        priority: Priority.normal,
        actions: [],
        note: '',
      );

  /// From json
  /// @param [json] json
  /// @return [Order] order
  ///
  @override
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  /// Get props
  /// @return [List<Object?>] props
  /// 
  @override
  List<Object?> get props => [
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
