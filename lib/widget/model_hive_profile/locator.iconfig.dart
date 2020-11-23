// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************


import 'package:get_it/get_it.dart';
import 'api_service.dart';
import 'hive_service.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<APIService>(() => APIService());
  g.registerLazySingleton<HiveService>(() => HiveService());
}
