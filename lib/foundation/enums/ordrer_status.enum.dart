import 'package:flutter/material.dart';

enum OrderStatus {
  pending(
    name: "En attente",
    color: Colors.grey,
  ),
  running(
    name: "En cours",
    color: Colors.blue,
  ),
  waitingForPaiement(
    name: "En attente de paiement",
    color: Colors.yellow,
  ),
  finished(
    name: "Réussie",
    color: Colors.green,
  ),
  failed(
    name: "Raté",
    color: Colors.red,
  ),
  canceled(
    name: "Annulé",
    color: Colors.deepPurple,
  );

  const OrderStatus({
    required this.name,
    required this.color,
  });

  final String name;
  final Color color;
}
