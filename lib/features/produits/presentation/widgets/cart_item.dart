import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';

class CartItem {
  final ProduitEntity produit;
  final String selectedSize;

  CartItem({
    required this.produit,
    required this.selectedSize,
  });

  // Pour SharedPreferences (JSON)
  Map<String, dynamic> toMap() {
    return {
      'produit': produit.toMap(),
      'selectedSize': selectedSize,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      produit: ProduitEntity.fromMap(map['produit']),
      selectedSize: map['selectedSize'],
    );
  }
}