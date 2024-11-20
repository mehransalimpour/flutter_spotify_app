import 'package:dio/dio.dart';
import 'package:flutter_spotify_app/data/datasorce/authentication_datasource.dart';
import 'package:flutter_spotify_app/data/datasorce/song_data_datasource.dart';
import 'package:flutter_spotify_app/data/repository/autentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/song_data_repository.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componenets
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(baseUrl: 'https://mpm.chbk.app/api/'),
    ),
  );

  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  //datasource
  locator
      .registerFactory<IAuthenticationDataSource>(() => AuthenticationRemote());
  locator.registerFactory<ISongDatasource>(() => SongRemoteDatasource());
  // locator.registerFactory<ISongPlayerDatasource>(
  //     () => SongPlayerRemoteDatasource());

  //repositry
  locator.registerFactory<IAuthenticationRepository>(
      () => AuthenticationRepository());
  locator.registerFactory<ISongRepository>(() => SongRepository());
  // locator.registerFactory<ISongPlayerRepository>(() => SongPlayerRepository());
}
