import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/data/repository/song_data_repository.dart';
import 'package:flutter_spotify_app/di/di.dart';
import 'package:flutter_spotify_app/ui/Home/bloc/home_event.dart';
import 'package:flutter_spotify_app/ui/Home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // final ICategoryRepository _categoryRepository = locator.get();
  final ISongRepository _homeRepository = locator.get();

  HomeBloc() : super(HomeInitState()) {
    on<HomeGetInitilzeData>((event, emit) async {
      emit(HomeLoadingState());

      var homeList = await _homeRepository.getsong();
      // var HomeList = await _HomeRepository.getHomes();
      // var hotestHomeList = await _HomeRepository.getHotest();
      // var bestSellerHomeList = await _HomeRepository.getBsetSeller();

      emit(HomeRequestSuccessState(homeList));
    });
  }
}
