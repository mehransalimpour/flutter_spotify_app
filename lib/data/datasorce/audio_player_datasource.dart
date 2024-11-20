// import 'package:dio/dio.dart';
// import 'package:flutter_spotify_app/data/model/song/song.dart';
// import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';
// import 'package:just_audio/just_audio.dart';

// import '../../di/di.dart';

// abstract class ISongPlayerDatasource {
//   Future<List<SongModel>> getSongPlayers(SongModel song);
// }

// class SongPlayerRemoteDatasource extends ISongPlayerDatasource {
//   final Dio _dio = locator.get();
//   @override
//   Future<List<SongModel>> getSongPlayers(SongModel song) async {
//     try {
//       var respones = await _dio.get(
//         'collections/song/records',
//       );
    
//       return respones.data['items']
//           .map<SongModel>((jsonObject) => SongModel.fromMapJson(jsonObject))
//           .toList();
//     } on DioException catch (ex) {
//       throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
//     } catch (ex) {
//       throw ApiExeption(0, 'unknown erorr');
//     }
//   }
// }
