import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';

part 'action.entity.g.dart';

/// Action
@JsonSerializable()
@CopyWith()
class OrderAction with SerializableMixin, EquatableMixin {
  /// Action
  /// @param [date] date
  /// @param [description] description
  ///
  OrderAction({
    required this.date,
    required this.description,
  });

  /// From json
  /// @param [json] json
  /// @return [OrderAction] order action
  ///
  @override
  factory OrderAction.fromJson(Map<String, dynamic> json) =>
      _$OrderActionFromJson(json);

  /// Action date
  final DateTime date;

  /// Action description
  final String description;

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() => _$OrderActionToJson(this);

  /// Get props
  /// @return [List<Object?>] props
  ///
  @override
  List<Object?> get props => <Object?>[
        date,
        description,
      ];
}
