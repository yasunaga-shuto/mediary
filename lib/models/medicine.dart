import "package:flutter/material.dart";
import "package:mediary/helpers/time_of_day_helper.dart";

class Medicine {
  final int id;
  final String name;
  final int? quantity;
  final String? unit;
  final TimeOfDay takenAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
      "id": id,
      "name": name,
      "quantity": quantity,
      "takenAt": takenAt,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> json) {
    return Medicine(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"],
      unit: json["unit"],
      takenAt: TimeOfDayHelper.toTimeOfDay(json["takenAt"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  @override
  String toString() {
    return "Medicine{id: $id, name: $name, quantity: $quantity, unit: $unit, takenAt: $takenAt, createdAt: $createdAt, updatedAt: $updatedAt}";
  }
}
