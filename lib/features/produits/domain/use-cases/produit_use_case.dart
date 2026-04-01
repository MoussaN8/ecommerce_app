import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:ecommerce_app/features/produits/domain/repositories/produit_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProduitUseCase {
  final ProduitRepository produitRepository;
  const ProduitUseCase({required this.produitRepository});
  Future<Either<Failures, List<ProduitEntity>>> call() async {
    return await produitRepository.getProduits();
  }
}
