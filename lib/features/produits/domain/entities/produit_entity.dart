class ProduitEntity {
  final String id;
  final String name;
  final int prix;
  final List<String> taille;
  final String description;
  final String categoryId;
  final bool isAvailable;
  final List<String> images;

  const ProduitEntity({
    required this.id,
    required this.name,
    required this.prix,
    required this.taille,
    required this.description,
    required this.categoryId,
    required this.images,
    required this.isAvailable,
  });
}
