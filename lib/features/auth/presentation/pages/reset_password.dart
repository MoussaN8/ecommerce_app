import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/utils/loader.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // clé pour accéder à l'état du formulaire
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              return showSnackBar(context, state.message, isError: true);
            }
            if (state is AuthSuccess) {
              showSnackBar(
                context,
                "Email de réinitialisation envoyé ! Vérifiez vos spams.",
              );

              if (!mounted) return;
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.signIn,
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
                    Image.asset(
                      'assets/images/emailSend.png',
                      width: 160,
                      height: 160,
                    ),

                    const Text(
                      "Entrez votre email pour recevoir un lien de récupération. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthForm(hintText: "Email", controller: _emailController),
                    const SizedBox(height: 20),
                    AuthButton(
                      textButton: "Envoyer le lien",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Ferme le clavier
                          FocusScope.of(context).unfocus();
                          context.read<AuthBloc>().add(
                            AuthResetPasswordEvent(
                              email: _emailController.text.trim(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
