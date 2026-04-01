import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:flutter/material.dart';

class ProduitItem extends StatefulWidget {
  final ProduitEntity produit;

  const ProduitItem({super.key, required this.produit});

  @override
  State<ProduitItem> createState() => _ProduitItemState();
}

class _ProduitItemState extends State<ProduitItem> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _scale = 1.1), // Zoom au toucher
          onTapUp: (_) => setState(() => _scale = 1.0), // Retour à la normale
          onTapCancel: () => setState(() => _scale = 1.0),
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.categoryProduitPage);
          },
          child: Column(
            children: [
              Stack(
                children: [
                  AnimatedScale(
                    scale: _scale,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: Image.network(
                      widget.produit.images[0],
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.produit.name,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.produit.prix} FCFA',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
