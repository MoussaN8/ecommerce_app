part of 'profil_image_cubit.dart';

sealed class ProfilImageState extends Equatable {
  const ProfilImageState();

  @override
  List<Object> get props => [];
}

final class ProfilImageInitial extends ProfilImageState {}

final class ProfilImageLoading extends ProfilImageState {}

final class ProfilImageLoaded extends ProfilImageState {
  final String? profilImage;
  const ProfilImageLoaded({required this.profilImage});
}

final class ProfilImageError extends ProfilImageState {
  final String message;
  const ProfilImageError({required this.message});
  @override
  List<Object> get props => [message];
}

class ProfilImageSuccess extends ProfilImageState {
  final String message;
  const ProfilImageSuccess(this.message);
}
