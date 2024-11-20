// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spotify_app/data/model/song/song.dart';
// import 'package:flutter_spotify_app/ui/Home/bloc/home_bloc.dart';
// import 'package:flutter_spotify_app/ui/Home/bloc/home_state.dart';
// import 'package:flutter_spotify_app/utils/helpers/is_dark_mode.dart';
// import 'package:flutter_spotify_app/utils/theme/app_colors.dart';

// class NewsSongs extends StatelessWidget {
//   const NewsSongs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeBloc(),
//       child: SizedBox(
//           height: 200,
//           child: BlocBuilder<HomeBloc, HomeState>(
//             builder: (context, state) {
//               if (state is HomeLoadingState) {
//                 return Container(
//                     alignment: Alignment.center,
//                     child: const CircularProgressIndicator());
//               }

//               if (state is HomeRequestSuccessState) {
//                 return state.homeSongmodellist.fold((exceptionMessage) {
//                   return Text(exceptionMessage);
//                 }, (homesongList) {
//                   return _songs(homesongList);
//                 });
//               }

//               return Container(color);
//             },
//           )),
//     );
//   }

//   Widget _songs(List<SongModel> song) {
//     return ListView.separated(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext context) => Container()
//                       //  SongPlayerPage(
//                       //   songEntity: songs[index],
//                       // )
//                       ));
//             },
//             child: SizedBox(
//               width: 160,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: NetworkImage(song[index].image ?? ''))),
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           transform: Matrix4.translationValues(10, 10, 0),
//                           decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: context.isDarkMode
//                                   ? AppColors.darkGrey
//                                   : const Color(0xffE6E6E6)),
//                           child: Icon(
//                             Icons.play_arrow_rounded,
//                             color: context.isDarkMode
//                                 ? const Color(0xff959595)
//                                 : const Color(0xff555555),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     song[index].title ?? '',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     song[index].artist ?? '',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w400, fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) => const SizedBox(
//               width: 14,
//             ),
//         itemCount: song.length);
//   }
// }
