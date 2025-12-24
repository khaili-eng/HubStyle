class ProductsModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double? discountedPrice;
  final int? discountPercent;
  final String category;
  final String subCategory;
  final String brand;
  final List<String> sizes;
  final List<String> colors;
  final bool inStock;
  final String description;
  final double rating;
  final int reviewsCount;
  final bool isOnDiscount;
  final int stock;
  final int maxStack;
  final int? discountStock;


  const ProductsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.discountedPrice,
    this.discountPercent,
    this.stock = 0,
    this.discountStock = 0,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.sizes,
    required this.colors,
    this.inStock = true,
    this.description = "",
    this.rating = 0.0,
    this.maxStack = 0,
    this.reviewsCount = 0,
    this.isOnDiscount = true,

  });

  // تحويل المنتج إلى Map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "imageUrl": imageUrl,
      "price": price,
      "discountedPrice": discountedPrice,
      "discountPercent": discountPercent,
      "category": category,
      "subCategory": subCategory,
      "brand": brand,
      "sizes": sizes,
      "colors": colors,
      "inStock": inStock,
      "description": description,
      "rating": rating,
      "reviewsCount": reviewsCount,
      "isOnDiscount": isOnDiscount,
      "stock": stock,
      "maxStack": maxStack,
      "discountStock": discountStock,

    };
  }

  // إنشاء المنتج من Map
  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      id: map["id"] ?? "",
      name: map["name"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
      price: (map["price"] ?? 0.0).toDouble(),
      discountedPrice: map["discountedPrice"] != null
          ? (map["discountedPrice"] as num).toDouble()
          : null,
      discountPercent: map["discountPercent"] != null
          ? (map["discountPercent"] as num).toInt()
          : null,
      category: map["category"] ?? "",
      subCategory: map["subCategory"] ?? "",
      brand: map["brand"] ?? "",
      sizes: List<String>.from(map["sizes"] ?? []),
      colors: List<String>.from(map["colors"] ?? []),
      inStock: map["inStock"] ?? true,
      description: map["description"] ?? "",
      rating: (map["rating"] ?? 0.0).toDouble(),
      reviewsCount: (map["reviewsCount"] ?? 0).toInt(),
      isOnDiscount: map["isOnDiscount"] ?? true,
      stock: (map["stock"] ?? 0).toInt(),
      maxStack: (map["maxStack"] ?? 0).toInt(),
      discountStock: map["discountStock"] != null
          ? (map["discountStock"] as num).toInt()
          : 0,

    );
  }
}
