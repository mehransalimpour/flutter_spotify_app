import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_app/data/datasorce/song_data_datasource.dart';
import 'package:flutter_spotify_app/data/model/song/song.dart';
import 'package:flutter_spotify_app/di/di.dart';
import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';

abstract class ISongRepository {
  Future<Either<String, List<SongModel>>> getsong();
}

class SongRepository extends ISongRepository {
  final ISongDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<SongModel>>> getsong() async {
    try {
      var respons = await _datasource.getsongs();
      return right(respons);
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

  // @override
  // Future<Either<String, List<SongModel>>> getSongPlayers(String url) async {
  //   try {
  //     var respons = await _datasource.getSongPlayers(url);
  //     return right(respons);
  //   } on ApiExeption catch (ex) {
  //     return left(ex.message ?? 'خطا محتوای متنی ندارد');
  //   }
}
