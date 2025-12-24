import 'package:untitled7/features/products/data/models/products_mdels.dart';

import '../../../../core/entity/product_entity.dart';
import '../../repo/product_repo.dart';

class GetProductsUseCase {
  final ProductRepo repository;

  GetProductsUseCase(this.repository);

  Future<List<ProductsModel>> call() async {
    return await repository.getProducts();
  }
}