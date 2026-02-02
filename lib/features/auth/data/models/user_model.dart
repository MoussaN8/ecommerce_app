import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.nom,
    required super.prenom,
    required super.email,
  });

  // on transforme les données qui proviennent de firabase en un objet dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String? ?? '',
      nom: json['nom'] as String? ?? '',
      prenom: json['prenom'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  // lorsqu'on envoie nos données vers fireStore
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'nom': nom, 'prenom': prenom, 'email': email};
  }
}
