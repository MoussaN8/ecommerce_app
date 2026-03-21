import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/myUser/my_user.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String nom,
    required String prenom,
    required String email,
    required String password,
  });
  Future<UserModel> signIn({required String email, required String password});
  Future<void> resetPassword({required String email});
  Future<MyUser?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  const AuthRemoteDataSourceImpl({required this.auth, required this.firestore});
  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String nom,
    required String prenom,
    required String email,
    required String password,
  }) async {
    try {
      // création du compte dans firebase Auth
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user == null) {
        throw Exception("erreur lors de l'inscription");
      }
      // création du compte dans firebase store
      final userModel = UserModel(
        uid: user.uid,
        nom: nom,
        prenom: prenom,
        email: email,
        profilePic: null,
      );

      // enregistrement des données dans fireStore
      await firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());

      return userModel;
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception("Une erreur inconnue est survenue");
    }
  }

  //gestion du sign in
  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw Exception("Utilisateur introuvable !");
      }
      // récupération des infos du user via fireStore
      final userData = await firestore
          .collection('users')
          .doc(response.user!.uid)
          .get();

      if (userData.data() == null) {
        throw Exception("les données n'existent pas dans la base de données");
      }

      return UserModel.fromJson(userData.data()!);
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception("Une erreur inconnue est survenue");
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } catch (_) {
      throw Exception("erreur lors de l'envoie de l'email");
    }
  }

  //On récupére le token du user
  @override
  Future<MyUser?> getCurrentUser() async {
    try {
      final firebaseUser = auth.currentUser;
      if (firebaseUser == null) return null;

      // 🔥 Étape CRITIQUE
      await firebaseUser.reload();

      final refreshedUser = auth.currentUser;
      if (refreshedUser == null) return null;

      // 🔐 Sécurité Firestore
      final doc = await firestore
          .collection('users')
          .doc(refreshedUser.uid)
          .get();

      if (!doc.exists || doc.data() == null) {
        // user Auth existe mais données Firestore absentes
        await auth.signOut();
        return null;
      }

      return MyUser.fromMap(doc.data()!);
    } catch (e) {
      // token invalide / user supprimé
      await auth.signOut();
      return null;
    }
  }
}
