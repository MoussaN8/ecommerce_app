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

  // on transforme l'objet en format json
  Map<String, dynamic> toMap() {
    return {'name': name, 'prix': prix, 'taille': taille, 'images': images};
  }

  // on créé un objet à partir du map (json)
  factory ProduitEntity.fromMap(Map<String, dynamic> map) {
    return ProduitEntity(
      id: map['id'],
      name: map['name'],
      prix: map['prix'],
      taille: List<String>.from(map['taille']),
      description: map['description'],
      categoryId: map['categoryId'],
      images: List<String>.from(map['images']),
      isAvailable: map['isAvailable'],
    );
  }
}
