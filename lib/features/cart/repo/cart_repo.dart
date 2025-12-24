import 'package:untitled7/features/cart/data/model/cart_item_model.dart';

abstract class CartRepo{
  Future<void> saveCart(List<CartItem> items);
  Future<List<CartItem>>loadCart();
  Future<void>clearCart();
}