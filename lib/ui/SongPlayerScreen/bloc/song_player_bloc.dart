import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';

import 'song_player_event.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  AudioPlayer _audioPlayer = AudioPlayer();

  SongPlayerBloc() : super(SongPlayerinitState()) {
    on<PlayOrPauseSongEvent>((event, emit) async {
      if (_audioPlayer.playing) {
        _audioPlayer.stop();
      } else {
        _audioPlayer.play();
      }
      emit(SongPlayerLoaded(songPosition: _audioPlayer.positionStream, songDuration: _audioPlayer.duration, playing: _audioPlayer.playing));
    });

    on<PauseSongEvent>((event, emit) async {
      _audioPlayer.stop();
      emit(SongPlayerLoaded(songPosition: _audioPlayer.positionStream, songDuration: _audioPlayer.duration, playing: _audioPlayer.playing));
    });

    on<PlaySongEvent>((event, emit) async {
      _audioPlayer.play();
      emit(SongPlayerLoaded(songPosition: _audioPlayer.positionStream, songDuration: _audioPlayer.duration, playing: _audioPlayer.playing));
    });

    on<LoadSongEvent>((event, emit) async {
      emit(SongPlayerLoading());

      try {
        await _audioPlayer.setUrl(event.songEntity.songfile ?? '');
        emit(SongPlayerLoaded(songPosition: _audioPlayer.positionStream, songDuration: _audioPlayer.duration, playing: _audioPlayer.playing));

      } catch (e) {
        emit(SongPlayerFailure());
      }
    });

    on<OnSlideSongEvent>((event, emit) {
      _audioPlayer.seek(Duration(milliseconds: event.newPosition.toInt()));
      emit(SongPlayerLoaded(songPosition: _audioPlayer.positionStream, songDuration: _audioPlayer.duration, playing: _audioPlayer.playing));
    },);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
