import 'package:ecommerce_app/features/auth/presentation/pages/reset_password.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_up.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/category_produit.dart';
import 'package:ecommerce_app/features/shop/home_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String resetPassword = '/resetPassword';
  static const String homePage = '/homePage';
  static const String emailSend = '/emailSend';
  static const String categoryProduitPage = '/categoryProduitPage';

  // on sépare les routes fiwes dess routes ans arguments

  static Map<String, WidgetBuilder> routes = {
    signIn: (context) => const SignIn(),
    signUp: (context) => const SignUp(),
    resetPassword: (context) => const ResetPassword(),
    homePage: (context) => const Homepage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name == categoryProduitPage) {
      // on récupère les arguments
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => CategoryProduitPage(
          titre: args['titre'],
          produits: args['produits'] as List<ProduitEntity>,
        ),
      );
    }
    // Route par défaut (si on ne trouve rien)
    return MaterialPageRoute(builder: (_) => const SignIn());
  }
}
