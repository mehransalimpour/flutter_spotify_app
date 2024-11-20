import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_app/data/model/song/song.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeRequestSuccessState extends HomeState {
  Either<String, List<SongModel>> songList;

  HomeRequestSuccessState(this.songList);
}
