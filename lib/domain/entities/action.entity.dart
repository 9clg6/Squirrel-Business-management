import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';

part 'action.entity.g.dart';

/// Action
///
@JsonSerializable()
@CopyWith()
class OrderAction with SerializableMixin, EquatableMixin {
  /// Action date
  final DateTime date;

  /// Action description
  final String description;

  /// Action
  ///
  OrderAction({
    required this.date,
    required this.description,
  });

  @override
  Map<String, dynamic> toJson() => _$OrderActionToJson(this);

  @override
  factory OrderAction.fromJson(Map<String, dynamic> json) =>
      _$OrderActionFromJson(json);

  @override
  List<Object?> get props => [
        date,
        description,
      ];
}
