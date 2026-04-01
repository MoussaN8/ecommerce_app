import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/produit_item.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final String titre;
  final List<ProduitEntity> produits;
  final VoidCallback onVoirTout;

  const ProductList({
    super.key,
    required this.titre,
    required this.produits,
    required this.onVoirTout,
  });

  @override
  Widget build(BuildContext context) {
    if (produits.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête de la section
        Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titre,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: onVoirTout,
                child: const Text(
                  "Voir tout",
                  style: TextStyle(color: AppPalette.primaryColor),
                ),
              ),
            ],
          ),
        ),
        // Liste horizontale des produits
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: produits.length,
            itemBuilder: (context, index) {
              final produit = produits[index];
              return ProduitItem(produit: produit);
            },
          ),
        ),
      ],
    );
  }
}
