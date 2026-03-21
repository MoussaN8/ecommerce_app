class UserEntity {
  final String uid;
  final String nom;
  final String prenom;
  final String email;
  final String? profilePic; 
  const UserEntity({
    required this.uid,
    required this.nom,
    required this.prenom,
    required this.email,
    this.profilePic
  });
}
