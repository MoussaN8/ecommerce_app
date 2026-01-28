import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;
  const AuthButton({
    super.key,
    required this.textButton,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primaryColor,
        fixedSize: Size(380, 50),
      ),
      child: Text(
        textButton,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
