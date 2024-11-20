import 'package:flutter/material.dart';

sealed class ChooseModeState {}

final class ChooseModeInitial extends ChooseModeState {
  final ThemeMode themeMode;
  ChooseModeInitial({required this.themeMode});
}
