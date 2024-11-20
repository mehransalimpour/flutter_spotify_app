import 'package:flutter/material.dart';
import 'package:flutter_spotify_app/data/model/song/song.dart';
import 'package:flutter_spotify_app/utils/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_app/utils/theme/app_colors.dart';

class PlayList extends StatelessWidget {
  const PlayList({required this.songs, super.key});
  final List<SongModel> songs;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Playlist',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'See More',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xffC6C6C6)),
                ),
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //    builder: (BuildContext context)
                      //   => SongPlayerPage(
                      //     songEntity: songs[index],
                      //   )
                      // )
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.isDarkMode
                                      ? AppColors.darkGrey
                                      : const Color(0xffE6E6E6)),
                              child: Icon(
                                Icons.play_arrow_rounded,
                                color: context.isDarkMode
                                    ? const Color(0xff959595)
                                    : const Color(0xff555555),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songs[index].title ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  songs[index].artist ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(songs[index]
                                .duration
                                .toString()
                                .replaceAll('.', ':')),
                            const SizedBox(
                              width: 20,
                            ),
                            // FavoriteButton(
                            //   songEntity: songs[index],
                            // )
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: songs.length)
          ],
        ),
      ),
    );
  }
}
