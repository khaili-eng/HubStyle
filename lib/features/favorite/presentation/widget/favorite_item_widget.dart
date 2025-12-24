import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/data/models/products_mdels.dart';
import '../manager/favorite_cubit.dart';

class FavoriteItemWidget extends StatelessWidget {
  final ProductsModel product;
  const FavoriteItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 60, height: 60),
        title: Text(product.name),
        subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
        trailing: IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: () => cubit.toggleFavorite(product),
        ),
      ),
    );
  }
}
