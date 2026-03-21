import 'dart:io';
import 'dart:developer'; // Pour les logs
import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';

class ChangeProfileImageUsecase {
  final ProfilPictureRepository repository;

  const ChangeProfileImageUsecase({required this.repository});

  Future<String> call({
    required String uid,
    required File image,
  }) async {
    try {
      log("USECASE: Début de l'upload...", name: "ProfileImage");
      
      // Étape 1 : Upload
      final imageUrl = await repository.uploadProfilPicture(
        uid: uid,
        image: image,
      );
      log("USECASE: Upload fini. URL reçue: $imageUrl", name: "ProfileImage");

      // Étape 2 : Mise à jour Firestore
      log("USECASE: Mise à jour de Firestore...", name: "ProfileImage");
      await repository.updateProfilPicture(
        uid: uid,
        url: imageUrl,
      );
      
      log("USECASE: Opération terminée avec succès !", name: "ProfileImage");
      return imageUrl;
    } catch (e) {
      log("USECASE ERROR: $e", name: "ProfileImage");
      rethrow;
    }
  }
}