import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/features/cart/presentation/manager/card_cubit.dart';
import 'package:untitled7/features/cart/repo/cart_repo_impl.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';

import '../../../cart/presentation/manager/card_state.dart';
import '../../../cart/repo/cart_repo.dart';

class BottomBar extends StatelessWidget {
  final ProductsModel product;
  const BottomBar({super.key,required this.product});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
          children: [
      Text(
      "\$${product.discountedPrice?.toStringAsFixed(2) ?? product.price.toStringAsFixed(2)}",
      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
    ),
    Spacer(),
         BlocProvider(
           create: (_)=>CartCubit(CartRepoImpl()),
           child: BlocListener<CartCubit, CartState>(
             listener: (context, state) {
               if (state.warnMessage != null) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text(state.warnMessage!),
                     behavior: SnackBarBehavior.floating,
                   ),
                 );

                 Future.delayed(const Duration(milliseconds: 300), () {
                   context.read<CartCubit>().clearWarning();
                 });
               }
             },
             child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                       ),
                 ),
                 onPressed: () {
                      context.read<CartCubit>().addProduct(product);
                 },
                child: Text(
                      "Add to Cart",
                       style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
             ),
           ),
         ),
    ]
      )
    );
  }
}
