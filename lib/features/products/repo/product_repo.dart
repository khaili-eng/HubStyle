
import 'package:untitled7/features/products/data/models/products_mdels.dart';

import '../presentation/manager/product_cubit.dart';

abstract class ProductRepo{
  Future<List<ProductsModel>> getProducts();
  Future<List<ProductsModel>> searchProducts(String query);
  Future<ProductsModel> getProductDetails(String id);
  Future<List<ProductsModel>> getProductsByCategory(String category);
  Future<List<ProductsModel>> getProductsBySubCategory(String subCategory);

  Future<List<ProductsModel>> getRelatedProducts(String productId);
  Future<List<String>> getCategories();
  Future<List<String>> getSubCategories();
  Future<List<ProductsModel>> getDiscountedProducts();
  Future<List<ProductsModel>> getByBrand(String brand);
  Future<List<ProductsModel>> getBestSellingProducts();

}