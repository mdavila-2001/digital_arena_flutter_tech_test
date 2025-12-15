import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'data/services/api_service.dart';
import 'data/services/local_storage_service.dart';
import 'features/detail/cubit/detail_cubit.dart';
import 'features/favorites/cubit/favorites_cubit.dart';
import 'features/home/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => ApiService(sl()));
  sl.registerLazySingleton(() => LocalStorageService());

  sl.registerFactory(() => HomeCubit(sl(), sl()));
  sl.registerFactory(() => FavoritesCubit(sl()));
  sl.registerFactory(() => DetailCubit(sl()));
}