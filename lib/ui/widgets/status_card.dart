import 'package:flutter/material.dart';
import 'package:squirrel/foundation/enums/ordrer_status.enum.dart';

/// A card that displays the status of an order
class StatusCard extends StatelessWidget {

  /// Constructor of the status card
  /// @param [key] key
  /// @param [status] status
  ///
  const StatusCard({
    required this.status, super.key,
  });
  
  /// Status
  final OrderStatus status;

  /// Builds the status card
  /// @param [context] context
  /// @return [Widget] widget of the status card
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: status.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(status.name),
    );
  }
}
