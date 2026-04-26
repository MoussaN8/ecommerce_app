import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/presentation/providers/cart_provider.dart';
import 'package:ecommerce_app/features/produits/presentation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProduitView extends ConsumerStatefulWidget {
  final ProduitEntity produit;
  const ProduitView({super.key, required this.produit});

  @override
  ConsumerState<ProduitView> createState() => _ProduitViewState();
}

class _ProduitViewState extends ConsumerState<ProduitView> {
  String selectedSize = 'M';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              widget.produit.images.length > 1
                  ? CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: widget.produit.images.map((image) {
                        return Builder(
                          builder: (context) {
                            return Image.network(
                              image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        );
                      }).toList(),
                    )
                  : Image.network(
                      widget.produit.images.first,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(height: 16),
              Text(
                widget.produit.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '${widget.produit.prix} FCFA ',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              // modal qui permet d'afficher les différentes taille
              sizeSelector(),
              const SizedBox(height: 16),
              Text(
                widget.produit.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 1.5, // espace entre les lignes
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.primaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
                // AJOUTER AU PANIER VIA RIVERPOD
                // On passe l'entité ET la taille sélectionnée
                onPressed: () {
                  final itemAuPanier = CartItem(
                    produit: widget.produit,
                    selectedSize: selectedSize,
                  );
                  ref
                      .read(cartProvider.notifier)
                      .ajouterProduit(itemAuPanier);
                  // 2. NAVIGUER VERS LE PANIER
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // important pour centrer le contenu
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ajouter au panier',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizeSelector() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Taille',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            Row(
              children: [
                Text(
                  selectedSize,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _openSizeBottomSheet();
                  },
                  icon: Icon(Icons.arrow_drop_down),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openSizeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.separated(
            padding: EdgeInsets.all(12),
            shrinkWrap: true,
            itemCount: widget.produit.taille.length,
            itemBuilder: (context, index) {
              final t = widget.produit.taille[index];
              return _sizeItem(t);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        );
      },
    );
  }

  //liste des taille
  Widget _sizeItem(String taille) {
    final isSelected = selectedSize == taille;

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      tileColor: isSelected ? Colors.deepPurple : Colors.grey[900],
      title: Text(
        taille,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      onTap: () {
        setState(() {
          selectedSize = taille;
        });
        Navigator.pop(context); // ferme le bottom sheet
      },
    );
  }
}
