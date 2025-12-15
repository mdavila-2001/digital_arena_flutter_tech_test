import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'data/services/api_service.dart';
import 'features/home/cubit/home_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => ApiService(sl()));

  sl.registerFactory(() => HomeCubit(sl()));
}