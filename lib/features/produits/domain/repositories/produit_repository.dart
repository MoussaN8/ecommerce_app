import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/produits/domain/entities/produit_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProduitRepository {
  Future <Either<Failures,List<ProduitEntity>>> getProduits ();
}