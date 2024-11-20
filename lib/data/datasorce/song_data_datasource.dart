import 'package:dio/dio.dart';
import 'package:flutter_spotify_app/data/model/song/song.dart';
import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';
import 'package:just_audio/just_audio.dart';

import '../../di/di.dart';

abstract class ISongDatasource {
  Future<List<SongModel>> getsongs();
  Future<void> getSongPlayers(SongModel url);
}

class SongRemoteDatasource extends ISongDatasource {
  final Dio _dio = locator.get();
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Future<List<SongModel>> getsongs() async {
    try {
      var respones = await _dio.get(
        'collections/songs/records',
      );
      return respones.data['items']
          .map<SongModel>((jsonObject) => SongModel.fromMapJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiExeption(0, 'unknown erorr');
    }
  }

  @override
  Future<void> getSongPlayers(SongModel url) async {
    await audioPlayer.setUrl(url.songfile.toString());
  }
}
