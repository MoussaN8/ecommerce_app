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

  // message en français pour le sign up
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
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(mapFirebaseSignInError(e.code)));
    } catch (_) {
      throw Exception(
        "Une erreur inconnue est survenue lors de la connexion !",
      );
    }
  }

  @override
  Future<Either<Failures, Unit>> resetPassword({required String email}) async {
    try {
      await authRemoteDataSource.resetPassword(email: email);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure(_mapFirebaseError(e.code)));
    } catch (_) {
      return const Left(AuthFailure("erreur inconnue"));
    }
  }

  // message en français pour le reset password
  String mapFirebaseErrorToMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return "L'adresse email n'est pas valide.";
      case 'user-not-found':
        return "Aucun compte n'existe avec cet email.";
      case 'too-many-requests':
        return "Trop de tentatives. Réessayez plus tard.";
      case 'network-request-failed':
        return "Problème de connexion internet.";
      default:
        return "Une erreur est survenue. Veuillez réessayer.";
    }
  }

  //message en français pour le sign in
  String mapFirebaseSignInError(String errorCode) {
    switch (errorCode) {
      // Erreurs communes (Reset Password & Sign In)
      case 'invalid-email':
        return "L'adresse email n'est pas valide.";
      case 'user-not-found':
        return "Aucun compte n'existe avec cet email.";
      case 'too-many-requests':
        return "Trop de tentatives. Votre compte a été temporairement bloqué. Réessayez plus tard.";
      case 'network-request-failed':
        return "Problème de connexion internet. Vérifiez votre réseau.";

      // Erreurs spécifiques au Sign In (Connexion)
      case 'wrong-password':
        return "Le mot de passe est incorrect.";
      case 'user-disabled':
        return "Ce compte a été désactivé par un administrateur.";
      case 'operation-not-allowed':
        return "La connexion par email et mot de passe n'est pas activée.";
      case 'invalid-credential':
        return "Les informations de connexion ne sont pas valides ou ont expiré.";

      // Erreur par défaut
      default:
        return "Une erreur est survenue lors de la connexion. Veuillez réessayer.";
    }
  }
}
