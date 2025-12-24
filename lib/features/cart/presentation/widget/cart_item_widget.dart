import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/cart/data/model/cart_item_model.dart';
import 'package:untitled7/features/cart/presentation/manager/card_cubit.dart';
import 'package:untitled7/features/cart/presentation/manager/card_state.dart';
import 'package:untitled7/features/cart/presentation/widget/quantity_button.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Card(
      elevation: 3,
      shadowColor: Colors.black26,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image_not_supported),
                    ),
              ),
            ),

            const SizedBox(width: 14),


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Price labels
                  if (item.product.isOnDiscount &&
                      item.product.discountedPrice != null) ...[
                    Row(
                      children: [
                        Text(
                          "${item.product.discountedPrice!.toStringAsFixed(
                              2)} \$",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${item.product.price.toStringAsFixed(2)} \$",
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ] else
                    Text(
                      "${item.product.price.toStringAsFixed(2)} \$",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  const SizedBox(height: 6),
                  Builder(builder: (context) {
                    final subtotal = cubit.itemSubtotal(item.product.id);
                    return Text(
                      "Subtotal: ${subtotal.toStringAsFixed(2)} \$",
                      style:
                      TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    );
                  }),
                ],
              ),
            ),


            BlocListener<CartCubit, CartState>(
              listener: (context, state) {
                if (state.warnMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.warnMessage!),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                  Future.delayed(const Duration(milliseconds: 300), () {
                    context.read<CartCubit>().clearWarning();
                  });
                }
              },
              child: Column(
                children: [
                  QuantityButton(
                    icon: Icons.remove,
                    color: Colors.orange,
                    onTap: () => cubit.decreaseQuantity(item.product.id),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      "${item.quantity}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  QuantityButton(
                    icon: Icons.add,
                    color: Colors.green,
                    onTap: () => cubit.increaseQuantity(item.product.id),
                  ),

                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: () => cubit.removeProduct(item.product.id),
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.redAccent,
                      child: Icon(Icons.delete, size: 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
