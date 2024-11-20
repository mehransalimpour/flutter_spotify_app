import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/data/model/song/song.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/bloc/song_player_bloc.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/bloc/song_player_event.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/bloc/song_player_state.dart';
import 'package:flutter_spotify_app/utils/theme/app_colors.dart';

import '../../utils/widgets/appbar/app_bar.dart';

class SongPlayerPage extends StatefulWidget {
  final SongModel songEntity;
  const SongPlayerPage({required this.songEntity, super.key});

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongPlayerBloc()..add(LoadSongEvent(widget.songEntity)),
      child: Scaffold(
        appBar: BasicAppbar(
          title: const Text(
            'Now playing',
            style: TextStyle(fontSize: 18),
          ),
          action: IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        ),
        body: BlocBuilder<SongPlayerBloc, SongPlayerState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: _songCover(context),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _songDetail(),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  if (state is SongPlayerLoading) ...{
                    const SliverToBoxAdapter(
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  } else ...{
                    if (state is SongPlayerLoaded) ...[
                      SliverToBoxAdapter(child: _songPlayer(context, state))
                    ],
                  }
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(widget.songEntity.image ?? ''))),
    );
  }

  Widget _songDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.songEntity.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.songEntity.artist ?? '',
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ],
        ),
        // FavoriteButton(songEntity: songEntity)
      ],
    );
  }

  Widget _songPlayer(BuildContext context,SongPlayerLoaded state ) {
    return StreamBuilder(
      stream: state.songPosition,
      builder: (context, snapshot) => Column(
        children: [
          Slider(
            value: snapshot.data?.inMilliseconds.toDouble() ?? 0.0,
            min: 0.0,
            max: state.songDuration?.inMilliseconds.toDouble() ?? 0.0,
            onChangeStart: (value) {
              context.read<SongPlayerBloc>().add(PauseSongEvent());
            },
            onChangeEnd: (value) {
              context.read<SongPlayerBloc>().add(PlaySongEvent());
            },
            onChanged: (value) {
              context.read<SongPlayerBloc>().add(OnSlideSongEvent(value));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDuration(snapshot.data ?? Duration.zero),
              ),
              Text(
                formatDuration(state.songDuration ?? Duration.zero),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              context.read<SongPlayerBloc>().add(PlayOrPauseSongEvent());
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primary),
              child: Icon(state.playing
                  ? Icons.pause
                  : Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
