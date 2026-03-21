import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<Failures, List<CategoryEntity>>> getCategorires();
}
