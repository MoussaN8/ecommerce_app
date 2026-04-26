import 'dart:convert';

import 'package:ecommerce_app/features/produits/presentation/widgets/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  // on créé une clé pour le cart
  static const String _cartKey = 'user_cart';

  // sauvegarder le panier
  static Future<void> saveCart(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson = items.map((item) => jsonEncode(item.toMap())).toList();

    await prefs.setStringList(_cartKey, cartJson);
  }

  // on récupére le panier

  static Future<List<CartItem>> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList(_cartKey);
    if (cartJson == null) return [];
    // on transforme chaque string json en obket produitEntity
    return cartJson
        .map((item) => CartItem.fromMap(jsonDecode((item))))
        .toList();
  }

  // vider le apnier
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
