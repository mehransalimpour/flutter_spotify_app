import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/DI/di.dart';
import 'package:flutter_spotify_app/ui/ChooseMode/bloc/choose_mode_bloc.dart';
import 'package:flutter_spotify_app/ui/Home/bloc/home_bloc.dart';
import 'package:flutter_spotify_app/ui/Home/home_screen.dart';

import 'utils/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItInit();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChooseModeBloc>(
      create: (context) => ChooseModeBloc(),
      child: BlocBuilder<ChooseModeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state,
            debugShowCheckedModeBanner: false,
            home: BlocProvider(
              create: (context) => HomeBloc(),
              child: const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
