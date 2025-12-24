import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/features/favorite/repo/favorite_repo.dart';

import '../../products/data/models/products_mdels.dart';

class FavoriteRepoImpl extends FavoriteRepo{
  static const _favoritesKey = "FAVORITES_DATA";
  @override
  Future<void> saveFavorites(List<ProductsModel> items) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = items.map((e) => e.toMap()).toList();
    prefs.setString(_favoritesKey, jsonEncode(jsonList));
  }
  @override
  Future<List<ProductsModel>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_favoritesKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.map((e) => ProductsModel.fromMap(e)).toList();
  }
  @override
  Future<void> removeFavorite(String productId) async {
    final items = await loadFavorites();
    final filtered = items.where((e) => e.id != productId).toList();
    await saveFavorites(filtered);
  }
}