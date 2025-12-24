import 'package:flutter/cupertino.dart';
import 'package:untitled7/features/products/presentation/view/products_details_screen.dart';
import 'package:untitled7/features/products/presentation/view/products_screen.dart';
import 'package:untitled7/features/test/presentation/view/forget_password_screen.dart';
import 'package:untitled7/features/home/presentation/view/home_screen.dart';
import 'package:untitled7/features/test/presentation/view/login_screen.dart';
import 'package:untitled7/features/test/presentation/view/register_screen.dart';
import 'package:untitled7/features/home/presentation/view/settings_screen.dart';
import 'package:untitled7/features/test/presentation/view/verification_screen.dart';

class RoutesApp {
  static const String login = "/login";
  static const String register = "/register";
  static const String forgetPassword = "/forget_password";
  static const String verification = "/verification";
  static const String home = '/home';
  static const String settings = '/settings';
  static const String productsScreen = '/productsScreen';
  static const String productsDetailsScreen = '/productsDetailsScreen';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    forgetPassword: (context) => ForgetPasswordScreen(),
    verification: (context) => VerificationScreen(),
    home: (context) => HomeScreen(),
    settings: (context) => SettingsScreen(),
    productsScreen: (context) => ProductsScreen(),


    productsDetailsScreen: (context) => const SizedBox(),
  };
}
