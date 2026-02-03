import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/core/myUser/my_user.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/getCurrentUser.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signIn_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signUp_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _signInUseCase = signInUseCase,
       _resetPasswordUseCase = resetPasswordUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpEvent);
    on<AuthSignInEvent>(_onAuthSignInEvent);
    on<AuthResetPasswordEvent>(_authResetPasswordEvent);
    on<AuthIsUserLoggedIn>(_getCurrentUser);
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

  //gestion reset password
  Future<void> _authResetPasswordEvent(
    AuthResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final res = await _resetPasswordUseCase(email: event.email);
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (_) => emit(AuthResetpasswordSuccess()),
    );
  }

  //récupération du user
  Future<void> _getCurrentUser(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final user = await _getCurrentUserUseCase();
    user.fold(
      (_) => emit(AuthUnauthenticated()),
      (user) => emit(AuthAuthenticated(user)),
    );
  }
}
