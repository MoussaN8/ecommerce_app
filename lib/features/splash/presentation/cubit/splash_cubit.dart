import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/di/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  // on récupére l'intance de firebase auth via getIt
  final FirebaseAuth _auth;
  SplashCubit(this._auth) : super(SplashLoading()) {
    checkSession();
  }
  Future<void> checkSession() async {
    // laisser le splash visible
    await Future.delayed(const Duration(seconds: 2));
    // firebase nous dit si le user s'est déja loggé
    User? user = _auth.currentUser;

    if (user != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnAuthenticated());
    }
  }
}
