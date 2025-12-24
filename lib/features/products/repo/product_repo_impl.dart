import 'package:untitled7/features/products/data/data_sources/product_local_data_source.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';
import 'package:untitled7/features/products/repo/product_repo.dart';

class ProductRepoImpl extends ProductRepo {
  final ProductLocalDataSource local;

  ProductRepoImpl({
    required this.local,
  });
  @override
  Future<List<ProductsModel>> getProducts() {
    return local.getProducts();
  }
  @override
  Future<List<ProductsModel>> getBestSellingProducts() async {
    final products = await local.getProducts();
    return products.where((product) => product.rating > 4).toList();
  }
  @override
  Future<List<ProductsModel>> getRegularProducts() async {
    final products = await local.getProducts();
    return products.where((product) => product.rating <= 4).toList();
  }
  @override
  Future<List<ProductsModel>> searchProducts(String query) {
    return local.searchProducts(query);
  }
  @override
  Future<ProductsModel> getProductDetails(String id) {
    return local.getProductDetails(id);
  }
  @override
  Future<List<ProductsModel>> getProductsByCategory(String category) {
    return local.getProductsByCategory(category);
  }

  @override
  Future<List<ProductsModel>> getProductsBySubCategory(String subCategory) {
    return local.getProductsBySubCategory(subCategory);
  }
  @override
  Future<List<ProductsModel>> getRelatedProducts(String productId) {
    return local.getRelatedProducts(productId);
  }
  @override
  Future<List<ProductsModel>> getDiscountedProducts() {
    return local.getDiscountedProducts();
  }

  @override
  Future<List<ProductsModel>> getByBrand(String brand) {
    return local.getByBrand(brand);
  }
  @override
  Future<List<String>> getCategories() {
    return local.getCategories();
  }

  @override
  Future<List<String>> getSubCategories() {
    return local.getSubCategories();
  }
}
