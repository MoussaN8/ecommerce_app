import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;
  const ResetPasswordUseCase({required this.repository});
  Future<Either<Failures, Unit>> call({required String email}) async {
    return await repository.resetPassword(email: email);
  }
}
