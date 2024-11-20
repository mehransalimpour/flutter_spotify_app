import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'choose_mode_event.dart';

class ChooseModeBloc extends Bloc<ChooseModeEvent, ThemeMode> {
  ChooseModeBloc() : super(ThemeMode.light) {
    on<ChangeModeEvent>((event, emit) {
      emit(event.isdark ? ThemeMode.dark : ThemeMode.light);
    });
  }
}
