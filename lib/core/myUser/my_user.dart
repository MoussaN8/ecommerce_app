// ignore_for_file: public_member_api_docs, sort_constructors_first


class MyUser {
  final String uid;
  final String email;
  final String nom;
  final String prenom;
  final String? profilePic; // l'url de l'image stocké dans firebase
  const MyUser({
    required this.uid,
    required this.email,
    required this.nom,
    required this.prenom,
    this.profilePic,
  });

  
// Pour transformer les données de Firestore en objet Dart
  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] as String  ,
      email: map['email'] as String,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      profilePic: map['profilePic'] != null ? map['profilePic'] as String : null,
    );
  }

  
}


