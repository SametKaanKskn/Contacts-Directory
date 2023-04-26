import 'package:bitirme/api/api_service.dart';
import 'package:bitirme/core/model/item_model.dart';
import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  List<Item> _items = [];
  ApiService _apiService = ApiService();

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    try {
      _items = await _apiService.getItems();
      notifyListeners();
    } catch (error) {
      throw Exception('Ögeler Firebase Veritabanından getirilemedi');
    }
  }

  Future<void> addItem(Item item) async {
    try {
      await _apiService.postItem(item);
      _items.add(item);
      notifyListeners();
    } catch (error) {
      throw Exception('Firebase Veritabanina öğe eklenemedi');
    }
  }

  Future<void> removeItem(Item item) async {
    try {
      await _apiService.removeItem(_items, item.id);
      _items.removeWhere((element) => element.id == item.id);
      notifyListeners();
    } catch (error) {
      throw Exception('Firebase Veritabanindan Veri Silinemedi');
    }
  }

  Future<void> updateItem(
      String itemId, String itemName, String itemPhone) async {
    try {
      await _apiService.updatePerson(itemId, itemName, itemPhone);
      final itemIndex = _items.indexWhere((element) => element.id == itemId);
      if (itemIndex != -1) {
        _items[itemIndex] = Item(id: itemId, name: itemName, phone: itemPhone);
        notifyListeners();
      }
    } catch (e) {
      print('Error updating item: $e');
    }
  }
}
