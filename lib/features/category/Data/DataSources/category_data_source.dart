import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/category/Data/Models/category_model.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryDataSourceImpl implements CategoryDataSource {
  final FirebaseFirestore firestore;
  const CategoryDataSourceImpl({required this.firestore});
  @override
  Future<List<CategoryModel>> getCategories() async {
    final categories = await firestore.collection('categories').get();

    return categories.docs
        .map((doc) => CategoryModel.fromJson(doc.data(), doc.id))
        .toList();
  }
}
