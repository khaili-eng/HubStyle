import '../../repo/product_repo.dart';

class GetCategoriesUseCase {
  final ProductRepo repository;

  GetCategoriesUseCase(this.repository);

  Future<List<String>> call() async {
    return await repository.getCategories();
  }
}