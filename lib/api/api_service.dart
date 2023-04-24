// services/api_service.dart
import 'dart:convert';
import 'package:bitirme/core/model/item_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl =
      'https://flutter-project-79b9e-default-rtdb.firebaseio.com/';

  Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse('$_baseUrl/items.json'));
    print(response);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data.entries
          .map((entry) => Item.fromJson(entry.key, entry.value))
          .toList();
    } else {
      throw Exception('Firebase Veritabanindan Veri Yüklenemedi');
    }
  }

  Future<void> postItem(Item item) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/items.json'),
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Firebase Veritabanina Veri Gönderilemedi');
    }
  }
}
