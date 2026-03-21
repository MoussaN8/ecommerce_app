import 'dart:io';

abstract class ProfilPictureRepository {
  Future<String> uploadProfilPicture({required String uid, required File image});
  Future<void> updateProfilPicture({required String uid, required String url});
  Future<void> removeProfilPicture({required String uid});
}
