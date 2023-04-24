
import 'package:bitirme/api/api_service.dart';
import 'package:bitirme/core/model/item_model.dart';
import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  List<Item> _items = [];
  ApiService _apiService = ApiService();

  List<Item> get items => _items;

  HomeProvider() {
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      _items = await _apiService.getItems();
      notifyListeners();
    } catch (error) {
      throw Exception('Ögeler Firebase Realtime Databaseden getirilemedi');
    }
  }

  Future<void> addItem(Item item) async {
    try {
      await _apiService.postItem(item);
      _items.add(item);
      notifyListeners();
    } catch (error) {
      throw Exception('Firebase Gerçek Zamanli Veritabanina öğe eklenemedi');
    }
  }
}
