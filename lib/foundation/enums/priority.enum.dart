import 'package:flutter/material.dart';

/// Priority
enum Priority {
  /// Low
  low(
    id: 1,
    name: 'Faible',
    color: Colors.green,
  ),

  /// Normal
  normal(
    id: 2,
    name: 'Normal',
    color: Colors.yellow,
  ),

  /// High
  high(
    id: 3,
    name: 'Élevé',
    color: Colors.red,
  );

  /// Constructor
  /// @param [id] id
  /// @param [name] name
  /// @param [color] color
  ///
  const Priority({
    required this.id,
    required this.name,
    required this.color,
  });

  /// Id
  final int id;

  /// Name
  final String name;

  /// Color
  final Color color;
}
