import 'dart:io';

import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';

class UploadProfileImageUsecase {
  final ProfilPictureRepository repository;
  const UploadProfileImageUsecase({required this.repository});
  Future<String> call({required String uid, required File image}) async {
   return await repository.uploadProfilPicture(uid: uid, image: image);
  }
}
