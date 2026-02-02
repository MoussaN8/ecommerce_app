/*  import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/core/utils/show_snackbar.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class Emailsend extends StatelessWidget {
  const Emailsend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //child: BlocConsumer<AuthBloc, AuthResetpasswordState>(
          //listener: (context, state) {
          //  if (state is AuthFailure) {
              //return showSnackBar(context, state.message);
           // }
            //if (state is AuthSuccess) {
             // showSnackBar(
              context,
                "Email de réinitialisation envoyé ! Vérifiez vos spams.",
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushReplacementNamed(context, AppRoutes.signIn);
              });
            }
          },
          builder: (context, state) {
            return Center
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/emailSend.png',
                    width: 160,
                    height: 160,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.signIn);
                    },
                    child: Text(
                      "Envoyer le lien",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
*/