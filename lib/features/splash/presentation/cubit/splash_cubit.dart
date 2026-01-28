import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    checkSession();
  }
  Future<void> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggin = prefs.getBool("isLoggedIn") ?? false;
    // laisser le splash visible
   await Future.delayed(const Duration(seconds: 2));
    if (isLoggin) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnAuthenticated());
    }
  }
}
