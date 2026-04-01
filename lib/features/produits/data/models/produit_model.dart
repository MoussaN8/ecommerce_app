import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';

class ProduitModel extends ProduitEntity {
  const ProduitModel({
    required super.id,
    required super.name,
    required super.prix,
    required super.taille,
    required super.description,
    required super.categoryId,
    required super.isAvailable,
    required super.images,
  });

  factory ProduitModel.fromJson(Map<String, dynamic> json, String documentId) {
    // On vérifie si la valeur est bien un booléen, sinon on met false
    final rawAvailable = json['isAvailable'];
    final bool available = (rawAvailable is bool) ? rawAvailable : false;
    // 1. Sécurisation du champ images
    List<String> imagesList = [];
    var rawImages = json['images'];

    if (rawImages is List) {
      // Si c'est déjà une liste, on la convertit proprement
      imagesList = List<String>.from(rawImages.map((e) => e.toString()));
    } else if (rawImages is String && rawImages.isNotEmpty) {
      // Si c'est une String (l'erreur actuelle), on la met dans une liste
      imagesList = [rawImages];
    }

    return ProduitModel(
      id: documentId,
      name: json['name'] ?? '',
      // Si prix est un int dans Firebase mais un double dans l'entité :
      prix: (json['prix'] ?? 0).round(),
      description: json['description'] ?? '',
      categoryId: json['category_id'] ?? '',
      isAvailable: available, // Utilise la variable sécurisée ici

      taille: List<String>.from(
        (json['taille'] as List? ?? []).map((e) => e.toString()),
      ),

      images: imagesList,
    );
  }
}
