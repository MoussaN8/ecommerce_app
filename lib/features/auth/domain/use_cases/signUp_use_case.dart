import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpUseCase {
  final AuthRepository repository;
  const SignUpUseCase({required this.repository});
  Future<Either<Failures, UserEntity>> call({
    required String nom,
    required String prenom,
    required String email,
    required String password,
  })async {
    return repository.signUp(
      nom: nom,
      prenom: prenom,
      email: email,
      password: password,
    );
  }
}
