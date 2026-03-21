import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';

class RemoveProfileImageUsecase {
  final ProfilPictureRepository repository;

  const RemoveProfileImageUsecase({required this.repository});
  Future<void> call({required String uid}) async {
    return await repository.removeProfilPicture(uid: uid);
  }
} 
