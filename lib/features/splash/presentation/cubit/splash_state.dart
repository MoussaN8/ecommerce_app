part of 'splash_cubit.dart';

@immutable
sealed class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

// app démarre on vérifie si le user s'est connecté
final class SplashLoading extends SplashState {}

// user déja connecté
final class SplashAuthenticated extends SplashState {}

// user déconnecté
final class SplashUnAuthenticated extends SplashState {}
