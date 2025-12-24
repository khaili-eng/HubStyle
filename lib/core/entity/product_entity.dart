import '../../features/products/data/models/product_model.dart';

class ProductEntity{
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
const ProductEntity({
  required this.id,
  required this.name,
  required this.description,
  required this.price,
  this.discountedPrice,
  required this.imageUrls,
  required this.category,
  required this.subCategories,
  required this.availableSizes,
  required this.availableColors,
  required this.material,
  required this.brand,
  required this.rating,
  required this.reviewCount,
  required this.isOnSale,
  required this.itemsOnDiscount,
  required this.tags,
  required this.careInstructions,
  required this.inStock,
  required this.stockCount,
  required this.createdAt,
  required this.relatedProductIds,
});
//for calculate discount
double get discountPercentage{
  if(discountedPrice == null)return 0.0;
  return ((price - discountedPrice!)/price)*100;
}
//check availableSizes (bool)
bool isSizeAvailable(String size){
  return availableSizes.containsKey(size) &&availableSizes[size]!>0;
}
//check availableColor (bool)
bool isColorAvailable(String color){
  return availableColors.contains(color);

}
}