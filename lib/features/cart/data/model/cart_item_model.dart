import 'package:equatable/equatable.dart';

import '../../../products/data/models/products_mdels.dart';

class CartItem extends Equatable{
  final ProductsModel product;
  int quantity;
  CartItem({
    required this.product,
  required this.quantity});
  @override
  List<Object?> get props => [product.id, quantity];
  Map<String,dynamic> toMap() {
    return {
      "product": product.toMap(), // بدل productId
      "quantity": quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: ProductsModel.fromMap(map["product"]), // كل بيانات المنتج مخزنة في map
      quantity: map["quantity"] ?? 1,
    );
  }



}