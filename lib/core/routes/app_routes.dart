import 'package:ecommerce_app/features/auth/presentation/pages/reset_password.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_up.dart';
import 'package:ecommerce_app/features/shop/shop.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String resetPassword = '/resetPassword';
  static const String shop = '/shop';
  

  static Map<String, WidgetBuilder> routes = {
    signIn: (context) => const SignIn(),
    signUp: (context) => const SignUp(),
    resetPassword: (context) => const ResetPassword(),
    shop: (context) => const Shopp(),

  };
}
