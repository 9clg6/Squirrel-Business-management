import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:init/domain/entities/action.entity.dart';
import 'package:init/domain/mixin/serializable.mixin.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';
import 'package:init/foundation/enums/priority.enum.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'order.entity.g.dart';

/// [Order] entity
///
@CopyWith()
@JsonSerializable()
class Order with EquatableMixin, SerializableMixin {
  final String id;
  final String clientContact;
  final String intermediaryContact;
  final double internalProcessingFee;
  final String trackId;
  final DateTime startDate;
  final Duration estimatedDuration;
  final String shopName;
  final double price;
  final double commissionRatio;
  final OrderStatus status;
  final String technique;
  final String? note;
  final Priority priority;
  final List<OrderAction>? _actions;
  List<OrderAction> get actions =>
      (_actions ?? [])..sort((a, b) => b.date.compareTo(a.date));

  double get commission => price * commissionRatio;
  double get margin => commission - internalProcessingFee;
  DateTime? get endDate => startDate.add(estimatedDuration);

  /// Constructor
  ///
  Order({
    String? id,
    required this.clientContact,
    required this.intermediaryContact,
    required this.internalProcessingFee,
    required this.trackId,
    required this.startDate,
    required this.estimatedDuration,
    required this.shopName,
    required this.price,
    required this.commissionRatio,
    required this.status,
    required this.technique,
    this.note,
    List<OrderAction>? actions,
    this.priority = Priority.normal,
  })  : _actions = actions,
        id = id ?? const Uuid().v4();

  @override
  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object?> get props => [
        id,
        clientContact,
        intermediaryContact,
        internalProcessingFee,
        trackId,
        priority,
        startDate,
        estimatedDuration,
        shopName,
        price,
        commissionRatio,
        status,
        technique,
        note,
        commission,
        margin,
        endDate,
        priority,
        actions,
      ];
}
