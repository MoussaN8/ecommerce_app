import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignInUseCase {
  final AuthRepository repository;
  const SignInUseCase({required this.repository});
  Future<Either<Failures, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return repository.signIn(email: email, password: password);
  }
}
