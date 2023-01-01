import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:karama/features/auth/domain/usecases/get_temp_data.dart';
import 'package:karama/features/auth/domain/usecases/get_token.dart';
import 'package:karama/features/auth/domain/usecases/get_verify_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/data/datasources/user_local_data_source.dart';
import 'features/auth/data/datasources/user_remote_data_source.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/login_user.dart';
import 'features/auth/domain/usecases/setup_user.dart';
import 'features/auth/domain/usecases/signup_user.dart';
import 'features/auth/domain/usecases/submit_onboarding_data.dart';
import 'features/auth/domain/usecases/verify_user.dart';
import 'features/auth/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/temp/bloc/temp_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Features - Auth + Temp

// Bloc
  sl.registerFactory(
      () => AuthBloc(loginUser: sl(), getUser: sl(), getToken: sl()));

  sl.registerFactory(
    () => TempBloc(
      signUp: sl(),
      getVerifyUseCase: sl(),
      verifyUser: sl(),
      getTempDataUseCase: sl(),
      submitOnboardingDataUseCase: sl(),
    ),
  );

// Usecases

  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => SetUpUserUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyUserUseCase(sl()));
  sl.registerLazySingleton(() => GetVerifyUseCase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => GetTempDataUseCase(sl()));
  sl.registerLazySingleton(() => SubmitOnboardingDataUseCase(sl()));

// Repository

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl(), localDataSource: sl()));
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

// Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

// External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
