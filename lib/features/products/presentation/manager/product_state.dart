import 'package:equatable/equatable.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';


enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
  empty,
}

class ProductState extends Equatable {
  final ProductStatus status;

  final List<ProductsModel> products;
  final List<ProductsModel> bestSellingProducts;
  final List<ProductsModel> discountedProducts;

  final List<String> categories;
  final List<String> subCategories;

  final String? selectedCategory;
  final String? selectedSubCategory;

  final ProductsModel? selectedProduct;
  final List<ProductsModel> relatedProducts;

  final String? errorMessage;

  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const [],
    this.bestSellingProducts = const [],
    this.discountedProducts = const [],
    this.categories = const [],
    this.subCategories = const [],
    this.selectedCategory,
    this.selectedSubCategory,
    this.selectedProduct,
    this.relatedProducts = const [],
    this.errorMessage,
  });
  ProductState copyWith({
    ProductStatus? status,
    List<ProductsModel>? products,
    List<ProductsModel>? bestSellingProducts,
    List<ProductsModel>? discountedProducts,
    List<String>? categories,
    List<String>? subCategories,
    String? selectedCategory,
    String? selectedSubCategory,
    ProductsModel? selectedProduct,
    List<ProductsModel>? relatedProducts,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      bestSellingProducts:
      bestSellingProducts ?? this.bestSellingProducts,
      discountedProducts:
      discountedProducts ?? this.discountedProducts,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedSubCategory:
      selectedSubCategory ?? this.selectedSubCategory,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading => status == ProductStatus.loading;
  bool get hasError => status == ProductStatus.error;
  bool get isEmpty => status == ProductStatus.empty;

  @override
  List<Object?> get props => [
    status,
    products,
    bestSellingProducts,
    discountedProducts,
    categories,
    subCategories,
    selectedCategory,
    selectedSubCategory,
    selectedProduct,
    relatedProducts,
    errorMessage,
  ];
}
