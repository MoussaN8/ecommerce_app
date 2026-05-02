import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/produits/presentation/providers/cart_provider.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Cart extends ConsumerWidget {
  // final String selectedSize;
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On écoute le cartProvider
    final cartAsync = ref.watch(cartProvider);
    // on écoute le provider  du prix total
    final prixTotal = ref.watch(cartTotalprovider);
    return Scaffold(
      appBar: AppBar(title: Text('Panier')),
      // On utilise .when pour gérer les états asynchrones
      body: cartAsync.when(
        data: (produits) {
          if (produits.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildCartItems(produits, ref);
        },
        error: (e, _) => Center(child: Text(e.toString())),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
      ),
      // ajout de la barre pour voir le prix total
      bottomNavigationBar: cartAsync.maybeWhen(
        data: (items) =>
            items.isEmpty ? null : _buildCheckhoutSection(prixTotal, context),
        orElse: () => null,
      ),
    );
  }

  // --- Écran Panier Vide ---
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Image.asset("assets/images/cartImage.png", height: 150),
          const SizedBox(height: 16),
          const Text(
            'Votre panier est vide',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primaryColor,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.homePage);
              },
              child: Text(
                'Explorer nos catégories',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(List<CartItem> items, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                // On appelle le notifier, pas le service directement
                ref.read(cartProvider.notifier).viderToutLePanier();
              }, // Logique pour vider le panier
              child: const Text(
                "Vider le panier",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final cartItemData = items[index];
                return cartItem(cartItemData, index, ref);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget cartItem(CartItem item, int index, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2D2634), // Fond de la carte (gris sombre)
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.produit.images[0],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    item.produit.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    softWrap: true, // Autorise le passage à la ligne
                    maxLines:
                        2, // Limite à 2 lignes si c'est VRAIMENT trop long
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'Taille :  ',
                    style: TextStyle(color: Colors.white),

                    children: [
                      TextSpan(
                        text: item.selectedSize,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '${item.produit.prix} FCFA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // le bouton de suppression
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () =>
                ref.read(cartProvider.notifier).supprimerProduit(index),
          ),
        ],
      ),
    );
  }

  // widget prix total
  Widget _buildCheckhoutSection(int total, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total : $total FCFA",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.primaryColor,
              minimumSize: const Size(double.infinity, 65),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.checkoutPage);
            },
            child: const Text(
              "Commander",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
