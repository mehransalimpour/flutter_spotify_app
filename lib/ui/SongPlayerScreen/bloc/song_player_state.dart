import 'package:just_audio/just_audio.dart';

abstract class SongPlayerState {}

class SongPlayerinitState extends SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final Stream<Duration> songPosition;
  final Duration? songDuration;
  final bool playing;

  SongPlayerLoaded({
    required this.songPosition,
    required this.songDuration,
    required this.playing,
  });
}

class SongPlayerFailure extends SongPlayerState {}
