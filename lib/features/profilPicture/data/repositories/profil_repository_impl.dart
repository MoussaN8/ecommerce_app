import 'dart:io';

import 'package:ecommerce_app/features/profilPicture/data/data_source/profil_picture_data_source.dart';
import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';

class ProfilRepositoryImpl implements ProfilPictureRepository {
  final ProfilPictureRemoteDataSource remoteDataSource;
  const ProfilRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadProfilPicture({
    required String uid,
    required File image,
  }) async {
    try {
      // Cloudinary gère l'upload
      return await remoteDataSource.uploadProfilPicture(uid: uid, image: image);
    } catch (e) {
      // On attrape l'erreur générée par notre DataSource (jsonDecode)
      throw Exception('Échec de l\'envoi vers Cloudinary : $e');
    }
  }

  @override
  Future<void> updateProfilPicture({
    required String uid,
    required String url,
  }) async {
    try {
      await remoteDataSource.updateProfilPicture(uid: uid, url: url);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour Firestore');
    }
  }

  @override
  Future<void> removeProfilPicture({required String uid}) async {
    try {
      // On appelle notre nouvelle méthode simplifiée
      await remoteDataSource.removeProfilPicture(uid: uid);
    } catch (e) {
      throw Exception('Erreur lors de la suppression');
    }
  }
}