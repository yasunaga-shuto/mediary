class Medicine {
  final int id;
  final String name;
  final int quantity;
  final String takenAt;

  Medicine(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.takenAt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'takenAt': takenAt,
    };
  }

  @override
  String toString() {
    return 'Medicine{id: $id, name: $name, quantity: $quantity, takenAt: $takenAt}';
  }
}
