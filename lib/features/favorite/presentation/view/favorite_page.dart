import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/favorite_cubit.dart';
import '../manager/favorite_state.dart';
import '../widget/empty_favorite.dart';
import '../widget/favorite_item_widget.dart';
import '../../../favorite/repo/favorite_repo_impl.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesCubit(FavoriteRepoImpl()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.items.isEmpty) {
                return const EmptyFavorite();
              }
              final width = MediaQuery.of(context).size.width;
              int crossAxisCount;
              if (width >= 900) {
                crossAxisCount = 3;
              } else if (width >= 600) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              return Padding(
                padding: EdgeInsets.all(12.w),
                child: GridView.builder(
                  itemCount: state.items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: crossAxisCount == 1
                        ? 3.4
                        : crossAxisCount == 2
                        ? 1.4
                        : 1.2,
                  ),
                  itemBuilder: (context, index) {
                    return FavoriteItemWidget(
                      product: state.items[index],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
