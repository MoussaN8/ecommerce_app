import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/produits/data/datasources/produit_data_source.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/domain/repositories/produit_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProduitRepositoryImpl implements ProduitRepository {
  final ProduitDataSource produitDataSource;
  const ProduitRepositoryImpl({required this.produitDataSource});
  @override
  Future<Either<Failures, List<ProduitEntity>>> getProduits() async {
    try {
      final produits = await produitDataSource.getProduits();
      return Right(produits);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

