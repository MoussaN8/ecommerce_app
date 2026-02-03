import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/core/myUser/my_user.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;
  const  GetCurrentUserUseCase({required this.repository});
  Future<Either<Failures,MyUser>>call() async {
    return await repository.getCurrentUser();
  }
}
