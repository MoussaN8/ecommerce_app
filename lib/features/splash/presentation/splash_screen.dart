import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> logoAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    logoAnimation = Tween<Offset>(begin: const Offset(0, 1.5), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: controller, curve: Curves.bounceOut),
        ); // effet de boule

    controller.forward(); // démarre l'animation
  }

  // on libére la mémoire
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.primaryColor,
      body: Center(
        child: SlideTransition(
          position: logoAnimation,
          child: Image.asset('assets/images/logo.png', width: 400, height: 400),
        ),
      ),
    );
  }
}
