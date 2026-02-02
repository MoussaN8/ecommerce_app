import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signIn_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signUp_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Services externes Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // dépendance getIt
  sl.registerFactory(() => SplashCubit(sl()));

  //2 Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl()),
  );

  //3 repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );

  //4 useCases
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerFactory(() => SignInUseCase(repository: sl()));
  sl.registerFactory(() => ResetPasswordUseCase(repository: sl()));

  //5 AuthBloc

  sl.registerFactory(
    () => AuthBloc(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );
}
