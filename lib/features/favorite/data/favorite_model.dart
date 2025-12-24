//زيادة من الممكن اعادة استخدام الProductsModel لان يحتوي على توابع toMap,fromMap

import 'package:untitled7/features/products/data/models/products_mdels.dart';

class FavoriteModel{
  final ProductsModel product;
  const FavoriteModel({required this.product});
  Map<String, dynamic> toMap() => {
    "product": product.toMap(),
  };
  factory FavoriteModel.fromMap(Map<String, dynamic> map) => FavoriteModel(
    product: ProductsModel.fromMap(map["product"]),
  );
}