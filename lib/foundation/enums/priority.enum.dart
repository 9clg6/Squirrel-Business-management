import 'package:flutter/material.dart';

enum Priority {
  low(
    id: 1,
    name: "Faible",
    color: Colors.green,
  ),
  normal(
    id: 2,
    name: "Normal",
    color: Colors.yellow,
  ),
  high(
    id: 3,
    name: "Élevé",
    color: Colors.red,
  );

  const Priority({
    required this.id,
    required this.name,
    required this.color,
  });

  final int id;
  final String name;
  final Color color;
}
