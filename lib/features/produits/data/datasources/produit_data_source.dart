import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/produits/data/models/produit_model.dart';

abstract class ProduitDataSource {
  Future<List<ProduitModel>> getProduits();
}

class ProduitDataSourceImpl implements ProduitDataSource {
  final FirebaseFirestore firestore;
  const ProduitDataSourceImpl({required this.firestore});

  @override
  Future<List<ProduitModel>> getProduits() async {
    try {
      final produits = await firestore.collection('produits').get();
      return produits.docs
          .map((p) => ProduitModel.fromJson(p.data(), p.id))
          .toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des produits: $e');
    }
  }
}
