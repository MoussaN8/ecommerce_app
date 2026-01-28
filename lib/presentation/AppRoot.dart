import 'package:ecommerce_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_up.dart';
import 'package:ecommerce_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:ecommerce_app/features/splash/presentation/splash_screen.dart';
import 'package:ecommerce_app/presentation/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Approot extends StatelessWidget {
  const Approot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashLoading) {
          return SplashScreen();
        }
        if (state is SplashAuthenticated) {
          return Homepage();
        }
        if (state is SplashUnAuthenticated) {
          return SignIn();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
