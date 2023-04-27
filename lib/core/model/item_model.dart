// models/item_model.dart
class Item {
  final String id;
  final String name;
  final String phone;
  final String details;

  Item(
      {required this.id,
      required this.name,
      required this.phone,
      required this.details});

  factory Item.fromJson(String id, Map<String, dynamic> json) {
    return Item(
      id: id,
      name: json['name'],
      phone: json['phone'],
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'details': details,
    };
  }
}
