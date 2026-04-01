import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/getCurrentUser.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signIn_use_case.dart';
import 'package:ecommerce_app/features/auth/domain/use_cases/signUp_use_case.dart';
import 'package:ecommerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ecommerce_app/features/category/Data/DataSources/category_data_source.dart';
import 'package:ecommerce_app/features/category/Data/Repository/category_repository_impl.dart';
import 'package:ecommerce_app/features/category/Domain/repository/category_repository.dart';
import 'package:ecommerce_app/features/category/Domain/use-cases/category_use_cases.dart';
import 'package:ecommerce_app/features/category/Presentation/bloc/category_bloc.dart';
import 'package:ecommerce_app/features/produits/data/datasources/produit_data_source.dart';
import 'package:ecommerce_app/features/produits/data/repositories/produit_repository_impl.dart';
import 'package:ecommerce_app/features/produits/domain/repositories/produit_repository.dart';
import 'package:ecommerce_app/features/produits/domain/use-cases/produit_use_case.dart';
import 'package:ecommerce_app/features/produits/presentation/bloc/produit_bloc.dart';
import 'package:ecommerce_app/features/profilPicture/data/data_source/profil_picture_data_source.dart';
import 'package:ecommerce_app/features/profilPicture/data/repositories/profil_repository_impl.dart';
import 'package:ecommerce_app/features/profilPicture/domain/repositories/profil_repository.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/change_profile_image_useCase.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/remove_profile_image_useCase.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/update_profile_image_useCase.dart';
import 'package:ecommerce_app/features/profilPicture/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:ecommerce_app/features/profilPicture/presentation/cubit/profil_image_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // dépendance getIt

  //2 Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(auth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<ProfilPictureRemoteDataSource>(
    () => ProfilPictureRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<CategoryDataSource>(
    () => CategoryDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<ProduitDataSource>(
    () => ProduitDataSourceImpl(firestore: sl()),
  );

  //3 repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfilPictureRepository>(
    () => ProfilRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(categoryDataSource: sl()),
  );
  sl.registerLazySingleton<ProduitRepository>(
    () => ProduitRepositoryImpl(produitDataSource: sl()),
  );

  //4 useCases
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl()));
  sl.registerFactory(() => SignInUseCase(repository: sl()));
  sl.registerFactory(() => ResetPasswordUseCase(repository: sl()));
  sl.registerFactory(() => GetCurrentUserUseCase(repository: sl()));
  sl.registerFactory(() => UploadProfileImageUsecase(repository: sl()));
  sl.registerFactory(() => UpdateProfileImageUsecase(repository: sl()));
  sl.registerFactory(() => RemoveProfileImageUsecase(repository: sl()));
  sl.registerFactory(() => ChangeProfileImageUsecase(repository: sl()));
  sl.registerFactory(() => CategoryUseCases(repository: sl()));
  sl.registerFactory<ProduitUseCase>(
    () => ProduitUseCase(produitRepository: sl()),
  );

  //5 AuthBloc
  sl.registerFactory(
    () => AuthBloc(
      signUpUseCase: sl(),
      signInUseCase: sl(),
      resetPasswordUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );
  sl.registerFactory(() => CategoryBloc(categoryUseCases: sl()));
  sl.registerFactory<ProduitBloc>(() => ProduitBloc(produitUseCase: sl()));

  //cubit
  sl.registerFactory(
    () => ProfilImageCubit(
      changeProfileImageUsecase: sl(),
      removeProfileImageUsecase: sl(),
      firestore: sl(),
    ),
  );
}
