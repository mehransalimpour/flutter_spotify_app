import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/ui/Home/playlist.dart';
import 'package:flutter_spotify_app/ui/SongPlayerScreen/song_player_screen.dart';
import 'package:flutter_spotify_app/utils/assets/app_images.dart';
import 'package:flutter_spotify_app/utils/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_app/utils/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/model/song/song.dart';
import '../../utils/assets/app_vectors.dart';
import '../../utils/widgets/appbar/app_bar.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitilzeData());

    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BasicAppbar(
                  hideBack: true,
                  action: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Container()));
                      },
                      icon: const Icon(Icons.person)),
                  title: SvgPicture.asset(
                    AppVectors.logo,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: _homeTopCard(),
              ),
              SliverToBoxAdapter(
                child: _tabs(),
              ),
              if (state is HomeLoadingState) ...{
                const SliverToBoxAdapter(
                  child: Column(
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
                )
              } else ...{
                if (state is HomeRequestSuccessState) ...[
                  state.songList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    },
                    (getdata) {
                      return Songs(
                        song: getdata,
                      );
                    },
                  )
                ],
                if (state is HomeRequestSuccessState) ...[
                  state.songList.fold(
                    (exceptionMessage) {
                      return SliverToBoxAdapter(
                        child: Text(exceptionMessage),
                      );
                    },
                    (getdata) {
                      return PlayList(
                        songs: getdata,
                      );
                    },
                  )
                ],

                // if (state is HomeRequestSuccessState) ...[
                //   state.categoryList.fold(
                //     (exceptionMessage) {
                //       return SliverToBoxAdapter(child: Text(exceptionMessage));
                //     },
                //     (categoryList) {
                //       return CategoryChargeScreen(categoryList);
                //     },
                //   )
                // ],
                //     ButtonVolumePage(),
              },
            ],
          );
        },
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      tabAlignment: TabAlignment.center,
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      tabs: const [
        Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Videos',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Artists',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Podcasts',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        )
      ],
    );
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(AppVectors.homeTopCard),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Songs extends StatelessWidget {
  const Songs({required this.song, super.key});
  final List<SongModel> song;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          height: 290,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => SongPlayerPage(
                                  songEntity: song[index],
                                )));
                  },
                  child: SizedBox(
                    width: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(song[index].image ?? ''))),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 40,
                                width: 40,
                                transform: Matrix4.translationValues(10, 10, 0),
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
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          song[index].title ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              song[index].artist ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                    width: 14,
                  ),
              itemCount: song.length),
        ),
      ),
    );
  }
}
