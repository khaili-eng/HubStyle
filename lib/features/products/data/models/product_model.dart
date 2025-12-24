import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/entity/product_entity.dart';

class ProductModel{
final String id;
final String name;
final String description;
final double price;
final double? discountedPrice;
final List<String> imageUrls;
final String category;
final List<String> subCategories;
final Map<String, int> availableSizes;
final List<ProductColor> availableColors;
final String material;
final String brand;
final double rating;
final int reviewCount;
final bool isOnSale;
final int itemsOnDiscount;
final List<String> tags;
final CareInstructions careInstructions;
final bool inStock;
final int stockCount;
final DateTime createdAt;
final List<String> relatedProductIds;

const ProductModel({
  required this.id,
  required this.name,
  required this.description,
  required this.price,
  required this.discountedPrice,
  required this.imageUrls,
  required this.category,
  required this.subCategories,
  required this.availableSizes,
  required this.availableColors,
  required this.material,
  required  this.brand,
  this.rating = 0.0,
  this.reviewCount = 0,
  this.isOnSale = false,
  this.itemsOnDiscount = 0,
  this.tags = const [],
  required this.careInstructions,
  required this.inStock,
  required this.stockCount,
  required  this.createdAt,
  this.relatedProductIds = const [],
} );
ProductEntity toEntity() =>ProductEntity(
  id:id,
  name:name,
  description: description,
  price: price,
  discountedPrice: discountedPrice,
  imageUrls: imageUrls,
  category: category,
  subCategories: subCategories,
  availableSizes: availableSizes,
  availableColors: availableColors,
  material: material,
  brand: brand,
  rating: rating,
  reviewCount: reviewCount,
  isOnSale: isOnSale,
  itemsOnDiscount: itemsOnDiscount,
  tags: tags,
  careInstructions: careInstructions,
  inStock: inStock,
  stockCount: stockCount,
  createdAt: createdAt,
  relatedProductIds: relatedProductIds,
);
//from json
factory ProductModel.fromJson(Map<String,dynamic>json){
  return ProductModel(
      id: json['id'],
      name:  json['name'],
      description:  json['description'],
      price: (json['price']as num).toDouble(),
      discountedPrice: json['discountedPrice'] !=null
      ?(json['discountedPrice']as num).toDouble():null,
      imageUrls: List<String>.from(json['imageUrls']),
      category: json['category'],
      subCategories: List<String>.from(json['subCategories']),
      availableSizes: Map<String,int>.from(json['availableSizes']),
      availableColors: (json['availableColors']as List).map((color)=>ProductColor.fromJson(color)).toList(),
      material: json['material'],
      brand: json['brand'],
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'],
      isOnSale: json['isOnSale'],
      itemsOnDiscount: json['itemsOnDiscount'],
      tags: List<String>.from(json['tags']),
      careInstructions: CareInstructions.fromJson(json['careInstructions']),
      inStock: json['inStock'],
      stockCount: json['stockCount'],
    createdAt: DateTime.parse(json['createdAt']),
    relatedProductIds: List<String>.from(json['relatedProductIds']),
  );
}
  static List<ProductModel> dummyProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'Classic White T-Shirt',
        description: 'Premium cotton t-shirt perfect for everyday wear. Comfortable and stylish.',
        price: 29.99,
        discountedPrice: 24.99,
        imageUrls: [
          'https://picsum.photos/400/500?random=1',
          'https://picsum.photos/400/500?random=2',
          'https://picsum.photos/400/500?random=3',
        ],
        category: 'Clothing',
        subCategories: ['T-Shirts', 'Casual'],
        availableSizes: {'S': 5, 'M': 8, 'L': 3, 'XL': 2},
        availableColors: [
          ProductColor(Colors.white, 'White'),
          ProductColor(Colors.black, 'Black'),
          ProductColor(Colors.grey, 'Grey'),
        ],
        material: '100% Cotton',
        brand: 'FashionHub',
        rating: 4.5,
        reviewCount: 128,
        isOnSale: true,
        itemsOnDiscount: 15,
        tags: ['casual', 'cotton', 'basic'],
        careInstructions: CareInstructions(
          machineWashable: true,
          dryCleanOnly: false,
          maxWashTemperature: 40,
          tumbleDry: true,
          ironable: true,
          ironTemperature: 110,
        ),
        inStock: true,
        stockCount: 18,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        relatedProductIds: ['2', '3'],
      ),
      // Add more dummy products...
    ];
  }
}
class ProductColor{
  final Color color;
  final String name;
  const ProductColor( this.color, this.name);
  factory ProductColor.fromJson(Map<String,dynamic>json){
    return ProductColor(Color(json['color']), json['name']);
  }
}
class CareInstructions {
  final bool machineWashable;
  final bool dryCleanOnly;
  final int maxWashTemperature;
  final bool tumbleDry;
  final bool ironable;
  final int ironTemperature;

  const CareInstructions({
    required this.machineWashable,
    required this.dryCleanOnly,
    required this.tumbleDry,
    required this.ironable,
    required this.ironTemperature,
    required this.maxWashTemperature
  });

  factory CareInstructions.fromJson(Map<String, dynamic>json){
    return CareInstructions(
        machineWashable: json['machineWashable'],
        dryCleanOnly: json['dryCleanOnly'],
        tumbleDry: json['tumbleDry'],
        ironable: json['ironable'],
        ironTemperature: json['ironTemperature'],
        maxWashTemperature: json['maxWashTemperature']
    );
  }

}