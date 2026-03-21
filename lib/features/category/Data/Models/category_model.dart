import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
  });

  // on transforme les données qui proviennent de firabase en un objet dart
  factory CategoryModel.fromJson(Map<String, dynamic> json,String documentId) {
    return CategoryModel(
      id: documentId,
      name: json['name'] ?? '',
      image: json['image'] ?? '' ,
      
    );
  }

  // lorsqu'on envoie nos données vers fireStore
  Map<String, dynamic> toJson() {
    return {'name': name, 'image': image};
  }
}


