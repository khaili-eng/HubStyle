import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled7/features/products/presentation/manager/product_cubit.dart';
import 'package:untitled7/features/products/presentation/manager/product_state.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductCubit cubit;
  late final PageController _bestSellingController;
  int _currentBestSellingIndex = 0;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductCubit>();
    cubit.loadProducts();
    cubit.loadBestSellingProducts();
    _bestSellingController = PageController(viewportFraction: 0.5);
  }
  @override
  void dispose() {
    _bestSellingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ProductStatus.error) {
            return Center(child: Text(state.errorMessage!));
          }

          if (state.status == ProductStatus.loaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (state.categories.isNotEmpty)
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        separatorBuilder: (_, __) => SizedBox(width: 6.w),
                        itemBuilder: (_, index) {
                          final cat = state.categories[index];
                          final selected = state.selectedCategory == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: selected,
                            onSelected: (_) {cubit.filterByCategory(cat);
                              cubit.filteredBestSellingProducts(cat);},
                          );
                        },
                      ),
                    ),
                  SizedBox(height: 16.h),
                  if (state.bestSellingProducts.isNotEmpty) ...[
                    Text(
                      'Best Selling',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 260.h + 24.h, // مساحة للكارد + Dots
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _bestSellingController,
                              itemCount: state.bestSellingProducts.length,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentBestSellingIndex = index;
                                });
                              },
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: ProductCard(
                                    product: state.bestSellingProducts[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              state.bestSellingProducts.length,
                                  (index) {
                                bool isActive = index == _currentBestSellingIndex;
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  width: isActive ? 12.w : 8.w,
                                  height: isActive ? 12.w : 8.w,
                                  decoration: BoxDecoration(
                                    color: isActive ? Colors.blue : Colors.grey.shade400,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],

                  if (state.products.isNotEmpty) ...[
                    Text(
                      'All Products',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.h),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.7,
                      children: state.products.map((product) {
                        return ProductCard(product: product);
                      }).toList(),
                    ),
                  ],

                  if (state.products.isEmpty && state.bestSellingProducts.isEmpty)
                    const Center(child: Text('لا يوجد منتجات')),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
