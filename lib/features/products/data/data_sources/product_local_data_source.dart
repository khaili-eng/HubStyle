import 'package:untitled7/features/products/data/models/products_mdels.dart';

class ProductLocalDataSource {

  final List<ProductsModel> _products = [
    ProductsModel(
      id: "1",
      name: "White Elegant Dress",
      imageUrl: "https://images.unsplash.com/photo-1609357698821-048267345332?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 40.0,
      discountedPrice: 30.0,
      discountPercent: 25,
      discountStock: 0,
      maxStack: 4,
      stock: 10,
      category: "Clothes",
      subCategory: "Women",
      brand: "Zara",
      sizes: ["S", "M", "L", "XL"],
      colors: ["White"],
      inStock: true,
      description: "Beautiful white summer dress with premium cotton fabric.",
      rating: 4.7,
      reviewsCount: 86,
    ),


    ProductsModel(
      id: "2",
      name: "Brown Casual Sweater",
      imageUrl: "https://images.unsplash.com/photo-1670087502693-ea2c85932098?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 32.0,
      discountedPrice: null,
      category: "Clothes",
      subCategory: "Women",
      maxStack: 9,
      brand: "H&M",
      sizes: ["S", "M", "L", "XL"],
      colors: ["Brown"],
      inStock: true,
      description: "Warm and comfortable sweater perfect for winter.",
      rating: 2,
      reviewsCount: 54,
    ),
    ProductsModel(
      id: "3",
      name: "Women's Blue Jeans",
      imageUrl: "https://plus.unsplash.com/premium_photo-1674828601362-afb73c907ebe?q=80&w=453&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 50.0,
      discountedPrice: 40.0,
      discountPercent: 20,
      discountStock: 12,
      maxStack: 3,
      stock: 20,
      category: "Clothes",
      subCategory: "Women",
      brand: "Levis",
      sizes: ["S", "M", "L", "XL"],
      colors: ["Blue"],
      inStock: true,
      description: "High-quality denim jeans with stretch fabric.",
      rating: 3,
      reviewsCount: 91,
    ),
    ProductsModel(
      id: "4",
      name: "White Sneakers",
      imageUrl: "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?q=80&w=725&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 60.0,
      discountedPrice: 50.0,
      discountPercent: 16,
      discountStock: 10,
      maxStack: 10,
      category: "Shoes",
      subCategory: "Women",
      brand: "Nike",
      sizes: ["36", "37", "38", "39", "40"],
      colors: ["White"],
      inStock: true,
      description: "Comfortable everyday sneakers for all outfits.",
      rating: 4.8,
      reviewsCount: 140,
    ),
    ProductsModel(
      id: "5",
      name: "Black High Heels",
      imageUrl: "https://images.unsplash.com/photo-1491553895911-0055eca6402d?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 85.0,
      discountedPrice: null,
      category: "Shoes",
      subCategory: "Women",
      brand: "Gucci",
      maxStack: 12,
      sizes: ["36", "37", "38", "39"],
      colors: ["Black"],
      inStock: true,
      description: "Elegant and luxurious heels perfect for events.",
      rating: 4.9,
      reviewsCount: 65,
    ),
    ProductsModel(
      id: "6",
      name: "Brown Leather Handbag",
      imageUrl: "https://images.unsplash.com/photo-1659708701940-e60893ef03d0?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 70.0,
      discountedPrice: 55.0,
      discountPercent: 20,
      discountStock: 2,
      maxStack: 12,
      category: "Accessories",
      subCategory: "Women",
      brand: "Dior",
      colors: ["Brown"],
      sizes: [],
      inStock: true,
      description: "Premium leather handbag perfect for daily use.",
      rating: 4.8,
      reviewsCount: 77,
    ),
    ProductsModel(
      id: "7",
      name: "Gold Necklace",
      imageUrl: "https://images.unsplash.com/photo-1758995115682-1452a1a9e35b?q=80&w=1380&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      price: 110.0,
      discountedPrice: 90.0,
      discountPercent: 18,
      maxStack: 45,
      category: "Accessories",
      subCategory: "Women",
      discountStock: 4,
      brand: "Cartier",
      colors: ["Gold"],
      inStock: true,
      description: "24K gold-plated necklace with elegant design.",
      rating: 4.9,
      reviewsCount: 120,
      sizes: [],
    ),

  ];
//to get all products
  Future<List<ProductsModel>> getProducts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products;
  }
  //to search
Future<List<ProductsModel>> searchProducts(String query) async{
    return _products.where((p)=>p.name.toLowerCase().contains(query.toLowerCase())).toList();
}
//to get products details
Future<ProductsModel> getProductDetails(String id) async{
    return _products.firstWhere((p)=>p.id==id);
}
//get products by category
Future<List<ProductsModel>> getProductsByCategory(String category) async{
    return _products.where((p)=>p.category==category).toList();
}
//get products by subCategory
Future<List<ProductsModel>> getProductsBySubCategory(String subCategory) async{
    return _products.where((p)=>p.subCategory==subCategory).toList();
}
//get discounted products
Future<List<ProductsModel>> getDiscountedProducts() async{
    return _products.where((p)=>p.discountedPrice !=null).toList();
}
//get by brand
Future<List<ProductsModel>> getByBrand(String brand) async{
    return _products.where((p)=>p.brand==brand).toList();
}
// get categories
Future<List<String>>getCategories() async{
    return _products.map((p)=>p.category).toSet().toList();
}
//get subCategories
Future<List<String>> getSubCategories()async{
    return _products.map((p)=>p.subCategory).toSet().toList();
}
// get Related products
Future<List<ProductsModel>> getRelatedProducts(String productId) async{
    final product= _products.firstWhere((p)=>p.id==productId);
    return _products.where((p)=>p.category==product.category&&p.id!=productId).toList();
}

}
