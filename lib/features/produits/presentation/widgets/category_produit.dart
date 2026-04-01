import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/produit_item.dart';

class CategoryProduitPage extends StatelessWidget {
  final String titre;
  final List<ProduitEntity> produits;

  const CategoryProduitPage({
    super.key,
    required this.titre,
    required this.produits,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$titre (${produits.length})'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: produits.isEmpty
          ? const Center(
              child: Text(
                "Aucun produit trouvé",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                // On utilise une grille pour que ça ressemble à tes captures d'écran
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 produits par ligne
                  childAspectRatio:
                      0.7, // Ajuste selon la hauteur de tes ProduitItem
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: produits.length,
                itemBuilder: (context, index) {
                  return ProduitItem(produit: produits[index]);
                },
              ),
            ),
    );
  }
}
