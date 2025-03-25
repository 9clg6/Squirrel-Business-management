import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Order status
@JsonEnum()
enum OrderStatus {
  /// Pending
  pending(
    name: 'En attente',
    color: Colors.grey,
  ),

  /// Running
  running(
    name: 'En cours',
    color: Colors.blue,
  ),

  /// Waiting for payment
  waitingForPaiement(
    name: 'En attente de paiement',
    color: Colors.lightGreen,
  ),

  /// Finished
  finished(
    name: 'Réussie',
    color: Colors.green,
  ),

  /// Failed
  failed(
    name: 'Raté',
    color: Colors.red,
  ),

  /// Canceled
  canceled(
    name: 'Annulé',
    color: Colors.deepPurple,
  );

  /// Constructor
  /// @param [name] name
  /// @param [color] color
  ///
  const OrderStatus({
    required this.name,
    required this.color,
  });

  /// From json
  /// @param [value] value
  /// @return [OrderStatus] order status
  ///
  factory OrderStatus.fromJson(String value) => OrderStatus.values.firstWhere(
        (OrderStatus element) => element.name == value,
        orElse: () => OrderStatus.pending,
      );

  /// Name
  final String name;

  /// Color
  final Color color;

  /// To json
  /// @return [String] json
  ///
  String toJson() => name;
}
