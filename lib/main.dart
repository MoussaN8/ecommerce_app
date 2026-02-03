import 'package:ecommerce_app/core/di/injection_container.dart';
import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/presentation/app_root.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies(); // initialisation de get It
  runApp(
    MultiBlocProvider(providers: [
     BlocProvider(create: (context)=>sl<AuthBloc>()..add(AuthIsUserLoggedIn()),),
     
    ],
     child: const MyApp()),
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
