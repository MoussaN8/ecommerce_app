import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/category/Data/DataSources/category_data_source.dart';
import 'package:ecommerce_app/features/category/Domain/Entity/category_entity.dart';
import 'package:ecommerce_app/features/category/Domain/repository/category_repository.dart';
import 'package:fpdart/src/either.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource categoryDataSource;
  const CategoryRepositoryImpl({required this.categoryDataSource});
  @override
  Future<Either<Failures, List<CategoryEntity>>> getCategorires() async {
    try {
      final res = await categoryDataSource.getCategories();
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
