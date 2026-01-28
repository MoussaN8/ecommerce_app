import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:ecommerce_app/presentation/AppRoot.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => SplashCubit(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Approot(),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
    );
  }
}
