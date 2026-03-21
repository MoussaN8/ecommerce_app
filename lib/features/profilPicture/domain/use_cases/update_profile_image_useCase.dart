import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';

class UpdateProfileImageUsecase {
  final ProfilPictureRepository repository;
  const UpdateProfileImageUsecase({required this.repository});

  Future<void> call({required String uid, required String url}) async {
    return await repository.updateProfilPicture(uid: uid, url: url);
  }
}
