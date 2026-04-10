import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<ProduitEntity> produit;
  const Cart({super.key, required this.produit});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: widget.produit.length <0 ? Center(
      child: ,
    ));
  }
}
