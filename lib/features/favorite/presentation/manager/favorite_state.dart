import 'package:equatable/equatable.dart';
import '../../../products/data/models/products_mdels.dart';


abstract class FavoritesState extends Equatable {
  final List<ProductsModel> items;
  const FavoritesState({required this.items});

  @override
  List<Object?> get props => [items];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial() : super(items: const []);
}

class FavoritesUpdated extends FavoritesState {
  const FavoritesUpdated({required List<ProductsModel> items})
      : super(items: items);

  FavoritesUpdated copyWith({List<ProductsModel>? items}) {
    return FavoritesUpdated(items: items ?? this.items);
  }
  bool isFavorite(String id) {
    return items.any((p) => p.id == id);
  }
//hydrated
  Map<String, dynamic> toMap() => {
    "items": items.map((e) => e.toMap()).toList(),
  };

  factory FavoritesUpdated.fromMap(Map<String, dynamic> map) {
    return FavoritesUpdated(
      items: List<ProductsModel>.from(
          (map["items"] as List<dynamic>).map((x) => ProductsModel.fromMap(x))),
    );
  }
}
