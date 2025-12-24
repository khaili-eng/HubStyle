import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';
import 'package:untitled7/features/products/presentation/view/products_details_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductsDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shadowColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [


            Flexible(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: 40,
                        ),
                      ),
                    ),


                    if (product.isOnDiscount)
                      Positioned(
                        top: 8.h,
                        left: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.local_offer, size: 14, color: Colors.white),
                              SizedBox(width: 4.w),
                              Text(
                                'Sale',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),


            Flexible(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.01.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        if (product.discountedPrice != null)
                          Text('\$${product.discountedPrice!.toStringAsFixed(2)}', style: TextStyle(color: Colors.green)),
                        if (product.discountedPrice != null) SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: product.discountedPrice != null ? Colors.grey : Colors.black87,
                              decoration: product.discountedPrice != null ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (product.isOnDiscount && product.discountStock != null && product.discountStock! > 0)
                      Text(
                        'Only ${product.discountStock} left',
                        style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12.sp),
                      ),

                    SizedBox(height: 4.h),
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
