import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color/app_colors.dart';
import '../manager/card_cubit.dart';
import '../manager/card_state.dart';
import '../widget/cart_item_widget.dart';
import '../widget/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 700;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state.warnMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.warnMessage!),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              Future.delayed(const Duration(milliseconds: 300), () {
                context.read<CartCubit>().clearWarning();
              });
            }
          },

          builder: (context, state) {
            if (state.items.isEmpty) {
              return const EmptyCart();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWide ? 30.w : 14.w,
                    ),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) =>
                        CartItemWidget(item: state.items[index]),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 38.w : 20.w,
                    vertical: isWide ? 26.h : 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12.r,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),

                  child: isWide
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTotalSection(state),
                      _buildCheckoutButton(),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTotalSection(state),
                      SizedBox(height: 14.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: _buildCheckoutButton(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTotalSection(CartState state) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Total:",
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        "\$${state.total.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );

  Widget _buildCheckoutButton() => ElevatedButton.icon(
    onPressed: () {},
    icon: Icon(
      Icons.arrow_forward_rounded,
      color: Colors.green,
      size: 24.sp,
    ),
    label: Text(
      "Checkout",
      style: TextStyle(
        color: Colors.green,
        fontSize: 17.sp,
      ),
    ),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 14.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
  );
}
