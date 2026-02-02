import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/core/utils/loader.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    super.dispose();
  }

  // clé pour accéder à l'état du formulaire
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              }
              if (state is AuthSuccess) {
                showSnackBar(context, "Compte créé avec succés !");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.shop,
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthForm(hintText: "Nom", controller: _nomController),
                      const SizedBox(height: 20),
                      AuthForm(
                        hintText: "Prenom",
                        controller: _prenomController,
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
                      AuthButton(
                        textButton: "S'inscrire",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                              AuthSignUpEvent(
                                nom: _nomController.text.trim(),
                                prenom: _prenomController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.signIn),
                        child: RichText(
                          text: const TextSpan(
                            text: "Vous avez déja un compte ? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Se connecter",
                                style: TextStyle(
                                  color: AppPalette.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
