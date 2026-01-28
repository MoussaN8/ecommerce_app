import 'package:ecommerce_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:ecommerce_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _SignInState();
}

class _SignInState extends State<ResetPassword> {
  final _emailController = TextEditingController();
  bool isPasswordHidden = true;

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Mot de passe Oublié ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                ),
                const SizedBox(height: 20),
                AuthForm(hintText: "Email", controller: _emailController),
                const SizedBox(height: 20),
                AuthButton(textButton: "Continuer", onPressed: () {}),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
