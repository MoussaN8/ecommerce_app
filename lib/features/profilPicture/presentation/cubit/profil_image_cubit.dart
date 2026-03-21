import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/core/utils/choisir_image.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/change_profile_image_useCase.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/remove_profile_image_useCase.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer';
part 'profil_image_state.dart';

class ProfilImageCubit extends Cubit<ProfilImageState> {
  final ChangeProfileImageUsecase changeProfileImageUsecase;
  final RemoveProfileImageUsecase removeProfileImageUsecase;
  final FirebaseFirestore firestore;
  ProfilImageCubit({
    required this.changeProfileImageUsecase,
    required this.removeProfileImageUsecase,
    required this.firestore,
  }) : super(ProfilImageInitial());

  //charger la photo depuis firestore
  Future<void> loadProfilmage({required String uid}) async {
    emit(ProfilImageLoading());
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      final data = doc.data();
      emit(ProfilImageLoaded(profilImage: data?['profilePic']));
    } catch (e) {
      emit(ProfilImageError(message: "Impossible de charger la photo"));
    }
  }

  // Supprimer la photo
  Future<void> removeProfilImage({required String uid}) async {
    emit(ProfilImageLoading());
    try {
      // Le Use Case appelle déjà repository.removeProfilPicture
      // qui lui-même fait le update(profilePic: delete) dans Firestore.
      await removeProfileImageUsecase(uid: uid);

      emit(const ProfilImageLoaded(profilImage: null));
      emit(const ProfilImageSuccess("Photo supprimée avec succès"));
    } catch (e) {
      emit(ProfilImageError(message: "Erreur lors de la suppression"));
    }
  }

  // Dans ProfilImageCubit

  Future<void> pickAndUploadImage(String uid) async {
    final File? image = await pickImage();
    if (image == null) return;

    // 1. On émet le chargement pour montrer le spinner
    emit(ProfilImageLoading());

    try {
      final String newImageUrl = await changeProfileImageUsecase(
        image: image,
        uid: uid,
      );

      log("Nouvelle URL: $newImageUrl", name: "ProfileImage");

      // On crée une URL unique pour "forcer" le rafraîchissement du cache
      final String finalUrl =
          "$newImageUrl?v=${DateTime.now().millisecondsSinceEpoch}";

      // ON EMET UNE SEULE FOIS l'état Loaded avec l'URL finalisée
      emit(ProfilImageLoaded(profilImage: finalUrl));

      // On informe du succès
      emit(const ProfilImageSuccess("Photo mise à jour !"));
    } catch (e) {
      log("Erreur: $e");
      emit(ProfilImageError(message: "Erreur lors de l'envoi"));
    }
  }
}
