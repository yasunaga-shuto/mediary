import 'package:flutter/material.dart';

class Medicine {
  final int id;
  final String name;
  final int? quantity;
  final String? unit;
  final TimeOfDay takenAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Medicine({
    required this.id,
    required this.name,
    this.quantity,
    this.unit,
    required this.takenAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'takenAt': takenAt,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
    id: json['id'],
    name: json['name'],
    quantity: json['quantity'],
    unit: json['unit'],
    takenAt: json['takenAt'],
    createdAt: json['createdAt'],
    updatedAt: json['updatedAt'],
  );

  @override
  String toString() {
    return 'Medicine{id: $id, name: $name, quantity: $quantity, unit: $unit, takenAt: $takenAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
