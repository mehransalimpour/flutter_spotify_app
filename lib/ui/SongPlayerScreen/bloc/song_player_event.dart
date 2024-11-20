
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

class LoadSongEvent extends SongPlayerEvent {
  LoadSongEvent();
}
