import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ecommerce_app/features/splash/presentation/splash_screen.dart';
import 'package:ecommerce_app/presentation/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Approot extends StatelessWidget {
  const Approot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return SplashScreen();
        }
        if (state is AuthAuthenticated) {
          return Homepage();
        }
        if (state is AuthUnauthenticated) {
          return SignIn();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
