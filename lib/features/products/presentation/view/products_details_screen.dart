import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/features/cart/repo/cart_repo_impl.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';
import 'package:untitled7/features/products/presentation/widgets/bottom_bar.dart';

import '../../../cart/presentation/manager/card_cubit.dart';
import '../../../favorite/presentation/manager/favorite_cubit.dart';
import '../../../favorite/presentation/manager/favorite_state.dart';
import '../../../favorite/repo/favorite_repo_impl.dart';

class ProductsDetailsScreen extends StatelessWidget {
  final ProductsModel product;
  const ProductsDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (_) => CartCubit(CartRepoImpl())),
        BlocProvider(create: (_) => FavoritesCubit(FavoriteRepoImpl())),
      ],
      // Added FavoritesCubit
      child: Scaffold(
        bottomNavigationBar: BottomBar(product: product),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350.h,
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: product.id,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 40,
                        child: BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            final isFav = state is FavoritesUpdated
                                ? state.isFavorite(product.id)
                                : false;
                            return GestureDetector(
                              onTap: () {
                                context.read<FavoritesCubit>().toggleFavorite(product);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: Icon(
                                  isFav ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        if (product.discountedPrice != null)
                          Text(
                            "\$${product.discountedPrice!.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        SizedBox(width: 12.w),
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            decoration: product.discountedPrice != null
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        if (product.discountedPrice != null)
                          Container(
                            margin: EdgeInsets.only(left: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "-${_calcDiscountPercent()}%",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 22.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 22.sp),
                        SizedBox(width: 6.w),
                        Text("4.6 (120 Reviews)", style: TextStyle(fontSize: 14.sp)),
                      ],
                    ),
                    SizedBox(height: 22.h),
                    Text("Available stock: ${product.stock} pieces"),
                    SizedBox(height: 6.h),
                    LinearProgressIndicator(
                      value: product.stock > 20 ? 1 : product.stock / 20,
                      color: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(height: 22.h),
                    Text("Description", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.h),
                    Text(
                      product.description ?? "No description available.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 24.h),
                    Text("Related Products", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 14.h),
                    SizedBox(
                      height: 160.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (_, __) => SizedBox(width: 12.w),
                        itemBuilder: (context, index) {
                          return Container(
                            width: 120.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.grey.shade100,
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Product $index",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                                SizedBox(height: 6.h),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int _calcDiscountPercent() {
    if (product.discountedPrice == null) return 0;
    final res = product.price - product.discountedPrice!;
    return ((res / product.price) * 100).round();
  }
}
