import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/ui/GetStartPage/start_page.dart';
import 'package:flutter_spotify_app/ui/Home/bloc/home_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/assets/app_vectors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SvgPicture.asset(AppVectors.logo)),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const GetstartPage()));
  }
}
