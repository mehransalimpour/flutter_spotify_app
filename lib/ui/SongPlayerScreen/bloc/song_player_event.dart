
import 'package:flutter_spotify_app/data/model/song/song.dart';

abstract class SongPlayerEvent {}

class SongPlayerGetPositionDataEvent extends SongPlayerEvent {
  Duration songPosition = Duration.zero;
  SongPlayerGetPositionDataEvent(this.songPosition);
}

class SongPlayerGetDataEvent extends SongPlayerEvent {}

class SongPlayerGetDurationDataEvent extends SongPlayerEvent {
  Duration songDuration = Duration.zero;

  SongPlayerGetDurationDataEvent(
    this.songDuration,
  );
}

class PlayOrPauseSongEvent extends SongPlayerEvent {}

class PauseSongEvent extends SongPlayerEvent {}

class PlaySongEvent extends SongPlayerEvent {}

class LoadSongEvent extends SongPlayerEvent {
  final SongModel songEntity;

  LoadSongEvent(this.songEntity);
}

class OnSlideSongEvent extends SongPlayerEvent {
  final double newPosition;

  OnSlideSongEvent(this.newPosition);
}
