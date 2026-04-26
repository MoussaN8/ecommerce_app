import 'package:ecommerce_app/core/di/injection_container.dart';
import 'package:ecommerce_app/core/routes/app_routes.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/category/Presentation/bloc/category_bloc.dart';
import 'package:ecommerce_app/features/produits/presentation/bloc/produit_bloc.dart';
import 'package:ecommerce_app/features/profilPicture/presentation/cubit/profil_image_cubit.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/presentation/app_root.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<ProfilImageCubit>()),
        BlocProvider(create: (_) => sl<CategoryBloc>()),
        BlocProvider(create: (_) => sl<ProduitBloc>()),
      ],
      child: MaterialApp(
        home: const Approot(),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes, // route simple
        onGenerateRoute: AppRoutes.onGenerateRoute, // Les routes avec arguments
        initialRoute: AppRoutes.signIn, // route initial
      ),
    );
  }
}
