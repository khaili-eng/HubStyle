import '../../products/data/models/products_mdels.dart';

abstract class FavoriteRepo{
  Future<void> saveFavorites(List<ProductsModel> items);
  Future<List<ProductsModel>> loadFavorites();
  Future<void> removeFavorite(String productId);
}