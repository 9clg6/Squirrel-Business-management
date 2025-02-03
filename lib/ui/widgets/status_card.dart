
import 'package:flutter/material.dart';
import 'package:init/foundation/enums/ordrer_status.enum.dart';

/// A card that displays the status of an order
///
class StatusCard extends StatelessWidget {
  /// Constructor of the status card
  /// 
  const StatusCard({
    super.key,
    required this.status,
  });

  /// The status of the order
  final OrderStatus status;

  /// Builds the status card
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