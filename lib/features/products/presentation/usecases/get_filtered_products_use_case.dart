import 'package:untitled7/features/products/data/models/products_mdels.dart';

import '../../../../core/entity/product_entity.dart';
import '../../repo/product_repo.dart';
import '../manager/product_cubit.dart';

class GetFilteredProductsUseCase {
  final ProductRepo repository;

  GetFilteredProductsUseCase(this.repository);

  Future<List<ProductsModel>> call( category) async {
    return await repository.getProductsByCategory(category);
  }
}