
import 'package:my_rick_and_morty/core/services/local/cache_consumer.dart';
import 'package:my_rick_and_morty/core/services/network/network_client.dart';
import 'package:my_rick_and_morty/data/datasource/remote/dio/dio_client.dart';
import 'package:my_rick_and_morty/data/datasource/remote/dio/logging_interceptor.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_data_layer/repo_imp/home_repo_imp.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_domain_layer/repo/home_repo.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/feature_domain_layer/use_case/home_use_case.dart';
import 'package:my_rick_and_morty/features/home_screen_feature/screen/view_model/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';



final getIt = GetIt.instance;

Future<void> init() async {

  /*
  * >USECASES<
  *
  *
  * */

  getIt.registerLazySingleton(() => HomeUseCase(homeRepo: getIt())) ;
  /*
  * Cubits
  * */
  getIt.registerLazySingleton(() => HomeCubit(homeUseCase: getIt())) ;


  /// Core
  getIt.registerLazySingleton(() => DioClient("https://rickandmortyapi.com/api", getIt(), loggingInterceptor: getIt(), cacheConsumer: getIt()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => NetworkClient());
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => AppPrefs(secureStorage: getIt(), sharedPreferences: getIt()));
  //
  // getIt.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(requestHeader: true, requestBody: true, responseHeader: true));
  // getIt.registerLazySingleton(() => ApiConsumer(getIt<Dio>(), getIt<PrettyDioLogger>(), getIt()));
  /*
  * Repository */
   getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(networkClient: getIt()));
}
