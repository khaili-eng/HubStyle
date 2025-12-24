import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:untitled7/features/favorite/repo/favorite_repo_impl.dart';
import '../../../products/data/models/products_mdels.dart';
import 'favorite_state.dart';


class FavoritesCubit extends HydratedCubit<FavoritesState> {
  final FavoriteRepoImpl repository;

  FavoritesCubit(this.repository) : super(const FavoritesInitial()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final items = await repository.loadFavorites();
    if (items.isNotEmpty) emit(FavoritesUpdated(items: items));
  }

  void toggleFavorite(ProductsModel product) {
    final currentItems = List<ProductsModel>.from(state.items);
    final exists = currentItems.any((e) => e.id == product.id);

    if (exists) {
      currentItems.removeWhere((e) => e.id == product.id);
    } else {
      currentItems.add(product);
    }

    emit(FavoritesUpdated(items: currentItems));
    repository.saveFavorites(currentItems);
  }

  void removeFavorite(String productId) {
    final currentItems = state.items.where((e) => e.id != productId).toList();
    emit(FavoritesUpdated(items: currentItems));
    repository.saveFavorites(currentItems);
  }


  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    try {
      return FavoritesUpdated.fromMap(json);
    } catch (_) {
      return const FavoritesInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    if (state is FavoritesUpdated) return state.toMap();
    return null;
  }
}
