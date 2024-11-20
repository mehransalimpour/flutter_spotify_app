import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/bloc/song_player_state.dart';
import 'package:just_audio/just_audio.dart';

import 'song_player_event.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  SongPlayerBloc() : super(SongPlayerinitState()) {
    on<SongPlayerGetPositionDataEvent>((event, emit) async {
      emit(SongPlayerLoading());
      audioPlayer.positionStream.listen((position) {
        event.songPosition = position;
      });

      emit(SongPlayerLoaded());
    });

    on<SongPlayerGetDurationDataEvent>((event, emit) async {
      emit(SongPlayerLoading());

      audioPlayer.durationStream.listen((duration) {
        event.songDuration = duration!;
      });
      emit(SongPlayerLoaded());
    });
    on<PlayOrPauseSongEvent>((event, emit) async {
      emit(SongPlayerLoading());
      if (audioPlayer.playing) {
        audioPlayer.stop();
      } else {
        audioPlayer.play();
      }
      emit(SongPlayerLoaded());
    });

    on<LoadSongEvent>((event, emit) async {
      emit(SongPlayerLoading());

      Future<void> LoadSong(String url) async {
        try {
          await audioPlayer.setUrl(url);
          emit(SongPlayerLoaded());
        } catch (e) {
          emit(SongPlayerFailure());
        }
      }
    });
  }
  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
