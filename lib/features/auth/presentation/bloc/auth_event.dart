part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpEvent extends AuthEvent {
  final String nom;
  final String prenom;
  final String email;
  final String password;
  const AuthSignUpEvent({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
  });
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  const AuthSignInEvent({required this.email, required this.password});
}
