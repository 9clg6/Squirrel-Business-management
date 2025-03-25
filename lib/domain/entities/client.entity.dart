import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:squirrel/domain/mixin/serializable.mixin.dart';
import 'package:uuid/uuid.dart';

part 'client.entity.g.dart';

/// [Client]
@CopyWith()
@JsonSerializable()
class Client with EquatableMixin, SerializableMixin {
  /// Constructor
  /// @param id: String
  /// @param name: String
  /// @param socialsName: String
  /// @param orderTotalAmount: double
  /// @param orderQuantity: int
  /// @param sponsorshipQuantity: int
  /// @param sponsorName: String?
  /// @param lastOrderDate: DateTime?
  /// @param firstOrderDate: DateTime?
  ///
  Client({
    required this.name,
    String? id,
    this.socialsName,
    this.orderTotalAmount = 0,
    this.commissionTotalAmount = 0,
    this.orderQuantity = 0,
    this.sponsorshipQuantity = 0,
    this.lastOrderDate,
    this.firstOrderDate,
  }) : id = id ?? const Uuid().v4();

  /// From json
  /// @param [json] json
  /// @return [Client] client
  ///
  @override
  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);

  /// Id
  final String id;

  /// Name
  final String name;

  /// Socials name
  final String? socialsName;

  /// Order total amount
  final double orderTotalAmount;

  /// Commission total amount
  final double commissionTotalAmount;

  /// Order quantity
  final int orderQuantity;

  /// Sponsorship quantity
  final int sponsorshipQuantity;

  /// Last order date
  final DateTime? lastOrderDate;

  /// First order date
  final DateTime? firstOrderDate;

  /// Props
  ///
  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        socialsName,
        orderTotalAmount,
        orderQuantity,
        sponsorshipQuantity,
        lastOrderDate,
        firstOrderDate,
        commissionTotalAmount,
      ];

  /// To json
  /// @return [Map<String, dynamic>] json
  ///
  @override
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
