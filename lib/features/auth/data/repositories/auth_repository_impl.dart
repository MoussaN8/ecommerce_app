import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  const AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failures, UserEntity>> signUp({
    required String nom,
    required String prenom,
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.signUpWithEmailAndPassword(
        nom: nom,
        prenom: prenom,
        email: email,
        password: password,
      );
      return right(response);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(_mapFirebaseError(e.code)));
    } catch (_) {
      return const Left(AuthFailure("erreur inconnue"));
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "Email déja utilisé ";
      case 'weak-password':
        return "Mot de passe trop faible";
      case "invalid-email":
        return "Email invalide";
      default:
        return "Erreur d'authentification";
    }
  }

  @override
  Future<Either<Failures, UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      return right(response);
    } catch (e) {
      return left(AuthFailure(e.toString().replaceAll('Exception', "")));
    }
  }
}
