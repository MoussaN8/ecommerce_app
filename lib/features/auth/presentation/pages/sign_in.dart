import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // clé pour accéder à l'état du formulaire
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Se Connecter",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const SizedBox(height: 20),
                AuthForm(hintText: "Email", controller: _emailController),
                const SizedBox(height: 20),
                AuthForm(
                  hintText: "Mot de passe",
                  controller: _passwordController,
                  obscureText: isPasswordHidden,
                  onToggleVisibility: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
                const SizedBox(height: 20),
                AuthButton(textButton: "Se connecter", onPressed: () {}),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.signUp),
                  child: RichText(
                    text: TextSpan(
                      text: "Vous n'avez pas de compte ? ",
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "S'inscrire",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.resetPassword),
                  child: RichText(
                    text: TextSpan(
                      text: "Mot de passe oubliée ?",
                      style: TextStyle(
                        color: AppPalette.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
