// models/item_model.dart
class Item {
  final String id;
  final String name;
  final String phone;

  Item({required this.id, required this.name, required this.phone});

  factory Item.fromJson(String id, Map<String, dynamic> json) {
    return Item(
      id: id,
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }
}
