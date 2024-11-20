// import 'package:dartz/dartz.dart';
// import 'package:flutter_spotify_app/data/datasorce/audio_player_datasource.dart';
// import 'package:flutter_spotify_app/data/model/song/song.dart';
// import 'package:flutter_spotify_app/di/di.dart';
// import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';

// abstract class ISongPlayerRepository {
//   Future<Either<String, List<SongModel>>> getSongPlayers();
// }

// class SongPlayerRepository extends ISongPlayerRepository {
//   final ISongPlayerDatasource _datasource = locator.get();
//   @override
//   Future<Either<String, List<SongModel>>> getSongPlayers() async {
//     try {
//       var respons = await _datasource.getSongPlayers();
//       return right(respons);
//     } on ApiExeption catch (ex) {
//       return left(ex.message ?? 'خطا محتوای متنی ندارد');
//     }
//   }
// }
