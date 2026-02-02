import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signIn_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signUp_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthSignInEvent>(_onAuthSignInEvent);
  }

  // Fcatorisation du code en regroupant ceux qu'ils ont en commun
  Future<void> _handleAuthAction(
    Emitter<AuthState> emit,
    Future<Either<Failures, UserEntity>> Function() authFunction,
  ) async {
    emit(AuthLoading());
    final res = await authFunction();
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (userEntity) => emit(AuthSuccess(userEntity: userEntity)),
    );
  }

  // Gestion du SignUp

  Future<void> _onAuthSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuthAction(
      emit,
      () => _signUpUseCase(
        nom: event.nom,
        prenom: event.prenom,
        email: event.email,
        password: event.password,
      ),
    );
  }

  //Gestion du Sign In
  Future<void> _onAuthSignInEvent(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _handleAuthAction(
      emit,
      () => _signInUseCase(email: event.email, password: event.password),
    );
  }
}
