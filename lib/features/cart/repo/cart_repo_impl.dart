import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled7/features/cart/data/model/cart_item_model.dart';
import 'package:untitled7/features/cart/repo/cart_repo.dart';

class CartRepoImpl extends CartRepo{
  static const _cartKey = "CART-DATA";
  @override
  Future<void>saveCart(List<CartItem>items) async{
final pref = await SharedPreferences.getInstance();
final cartJson = items.map((e)=>e.toMap()).toList();
pref.setString(_cartKey, jsonEncode(cartJson));
  }
  @override
  Future<List<CartItem>>loadCart() async{
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data == null) return [];
    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.map((e) => CartItem.fromMap(e)).toList();
  }
  @override
  Future<void> clearCart()async{
    final pref = await SharedPreferences.getInstance();
    pref.remove(_cartKey);
  }
}