import 'package:flutter_spotify_app/data/model/song/song.dart';

abstract class HomeEvent {}

class HomeGetInitilzeData extends HomeEvent {}

class HomeLikeSong extends HomeEvent {
  final SongModel songModel;

  HomeLikeSong(this.songModel);
}
