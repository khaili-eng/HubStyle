import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/products/presentation/manager/product_state.dart';

import 'package:untitled7/features/products/repo/product_repo.dart';

 class ProductCubit extends Cubit<ProductState>{
  final ProductRepo repo;
  List allProducts=[];
  List allBestSellingProducts =[];
  ProductCubit({required this.repo}):super(ProductState());
  Future<void> loadProducts()async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      final products = await repo.getProducts();
      final categories = await repo.getCategories();
      final subCategories = await repo.getSubCategories();
      if(products.isEmpty){
        emit(state.copyWith(status: ProductStatus.empty,errorMessage: "لا يوجد منتجات لعرضها "));
        return;
      }
      emit(state.copyWith(  status: ProductStatus.loaded,
        products: products,
        categories: ['All', ...categories],
        subCategories: ['All', ...subCategories],
        selectedCategory: 'All',
        selectedSubCategory: 'All',
      ));

    }catch(e){
      emit(state.copyWith(status: ProductStatus.error,
      errorMessage: e.toString()));
    }
  }
  Future<void> filteredBestSellingProducts(String category)async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      if(category=='All'){
        await loadBestSellingProducts();
        return;
      }
      final filtered = (await repo.getBestSellingProducts()).where((p)=>p.category==category).toList();
      if(filtered.isEmpty){
        emit(state.copyWith(status: ProductStatus.empty,errorMessage: "لا توجد منتجات ضمن هذة الفئة"));
        return;
      }
      emit(state.copyWith(status: ProductStatus.loaded,selectedSubCategory: category,bestSellingProducts: filtered));
      
    }catch(e){
emit(state.copyWith(status: ProductStatus.error,errorMessage: e.toString()));
    }
    
  }
  Future<void> filterByCategory(String category)async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      if(category=='All'){
        await loadProducts();
        return;
      }
      final products = await repo.getProductsByCategory(category);
      if(products.isEmpty){
        emit(state.copyWith(status: ProductStatus.empty,
        errorMessage: "لا توجد منتجات لعرضها ضمن هذة الفئة "));
        return;
      }
      final categories = await repo.getCategories();
      final subCategories = await repo.getSubCategories();
      emit(state.copyWith(status: ProductStatus.loaded,products: products,selectedCategory: category,selectedSubCategory: 'All'));
    }catch(e){
      emit(state.copyWith(status: ProductStatus.error,errorMessage: e.toString()));
    }
  }
  Future<void> filterBySubCategory(String subCategory)async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      if(subCategory=='All'){
        await loadProducts();
        return;
      }
      final products = await repo.getProductsBySubCategory(subCategory);
      if(products.isEmpty){
        emit(state.copyWith(status: ProductStatus.error,
            errorMessage: "لا يوجد منتجات ضمن الفئة الفرعية المحددة"));
        return;
      }
      final categories = await repo.getCategories();
      final subCategories = await repo.getSubCategories();
      emit(state.copyWith(
        status: ProductStatus.loaded,
        products: products,
        selectedSubCategory: subCategory,
        selectedCategory: 'All',
      ));
    }catch(e){
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  Future<void> searchProducts(String query) async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      final products=await repo.searchProducts(query);
      if(products.isEmpty){
        emit(state.copyWith(
          status: ProductStatus.empty,
          errorMessage: "لا يوجد نتائج لـ '$query'",
        ));
        return;
      }
      final categories = await repo.getCategories();
      final subCategories = await repo.getSubCategories();

      emit(state.copyWith(
        status: ProductStatus.loaded,
        products: products,
        selectedCategory: 'All',
        selectedSubCategory: 'All',
      ));
    }catch(e){
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));

    }
  }
  Future<void> loadProductsDetails(String id) async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      final product = await repo.getProductDetails(id);
      final related = await repo.getRelatedProducts(id);
      emit(state.copyWith(
        status: ProductStatus.loaded,
        selectedProduct: product,
        relatedProducts: related,
      ));
    }catch(e){
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  Future<void> loadDiscounted()async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
      final discounted = await repo.getDiscountedProducts();
      if(discounted.isEmpty){
        emit(state.copyWith(
          status: ProductStatus.empty,
          errorMessage: "لا يوجد منتجات مخفّضة حالياً",
        ));
        return;
      }
      final categories = await repo.getCategories();
      final subCategories = await repo.getSubCategories();

      emit(state.copyWith(
        status: ProductStatus.loaded,
        products: discounted,
        discountedProducts: discounted,
        selectedCategory: 'Discount',
        selectedSubCategory: 'All',
      ));
    }catch(e){
      emit(state.copyWith(
        status: ProductStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  //load best selling products
 Future<void> loadBestSellingProducts()async{
    emit(state.copyWith(status: ProductStatus.loading));
    try{
final bestSelling = await repo.getBestSellingProducts();
if(bestSelling.isEmpty){
  emit(state.copyWith(status: ProductStatus.empty,
      errorMessage: "لا يوجد منتجات الأكثر مبيعاً"));
  return;
}
emit(state.copyWith(status: ProductStatus.loaded,bestSellingProducts: bestSelling,));
    }
        catch(e){
      emit( state.copyWith(status: ProductStatus.error,
      errorMessage: e.toString()));

        }
 }
}
