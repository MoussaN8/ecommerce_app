import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failures, UserEntity>> signUp({
    required String nom,
    required String prenom,
    required String email,
    required String password,
  });
  Future<Either<Failures, UserEntity>> signIn({
    required String email,
    required String password,
  });
}
