import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/pages/sign_in.dart';
import 'package:ecommerce_app/features/profilPicture/presentation/cubit/profil_image_cubit.dart';
import 'package:ecommerce_app/features/shop/home_page.dart';
import 'package:ecommerce_app/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Approot extends StatefulWidget {
  const Approot({super.key});

  @override
  State<Approot> createState() => _ApprootState();
}

class _ApprootState extends State<Approot> {
  // Lancer la vérification APRÈS le premier build
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // C'EST ICI : Si on est connecté, on dit au Cubit de charger l'image
        if (state is AuthAuthenticated) {
          context.read<ProfilImageCubit>().loadProfilmage(uid: state.user.uid);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitial || state is AuthLoading) {
            return const SplashScreen();
          }
          if (state is AuthAuthenticated) {
           
            return const Homepage();
          }
          if (state is AuthUnauthenticated) {
            return const SignIn();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
