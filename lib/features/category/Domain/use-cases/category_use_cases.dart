import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';
import 'package:ecommerce_app/features/category/Domain/repository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryUseCases {
  final CategoryRepository repository;
  const CategoryUseCases({required this.repository});
  Future<Either<Failures, List<CategoryEntity>>> call() async {
    return await repository.getCategorires();
  }
}
