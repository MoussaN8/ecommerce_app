import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  const AuthForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[30],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: onToggleVisibility == null
            ? null
            : IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: onToggleVisibility,
              ),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hintText est requis !";
        } else {
          return null;
        }
      },
    );
  }
}
