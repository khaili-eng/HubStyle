import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled7/features/cart/repo/cart_repo_impl.dart';

import 'core/routes/routes_app.dart';
import 'core/theme/app_theme.dart';

import 'core/utils/notification_service.dart';
import 'features/cart/presentation/manager/card_cubit.dart';
import 'features/home/presentation/manager/theme_cubit.dart';
import 'features/products/presentation/manager/product_cubit.dart';
import 'features/products/repo/product_repo_impl.dart';
import 'features/products/data/data_sources/product_local_data_source.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  final token = await FirebaseMessaging.instance.getToken();
  print('FCM Token: $token');
  // Hydrated Bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(CartRepoImpl()),
        ),
        BlocProvider(create: (_) => ThemeCubit()..loadTheme()),
        BlocProvider(
          create: (_) => ProductCubit(
            repo: ProductRepoImpl(
              local: ProductLocalDataSource(),
            ),
          )..loadProducts(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                initialRoute: RoutesApp.register,
                routes: RoutesApp.routes,
              );
            },
          );
        },
      ),
    );
  }
}
