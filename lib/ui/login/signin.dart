import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/ui/Home/bloc/home_bloc.dart';
import 'package:flutter_spotify_app/ui/Home/home_screen.dart';
import 'package:flutter_spotify_app/ui/login/bloc/authentication_event.dart';
import 'package:flutter_spotify_app/ui/login/signup.dart';
import 'package:flutter_spotify_app/utils/widgets/button/basic_app_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/assets/app_vectors.dart';
import '../../utils/widgets/appbar/app_bar.dart';
import 'bloc/authentication_bloc.dart';
import 'bloc/authentication_state.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _username = TextEditingController(text: 'mehran');
  final TextEditingController _password =
      TextEditingController(text: '123123123');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        bottomNavigationBar: _signupText(context),
        appBar: BasicAppbar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(
                height: 50,
              ),
              _emailField(context),
              const SizedBox(
                height: 20,
              ),
              _passwordField(context),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitiateState) {
                    return BasicAppButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(
                              AuthLoadingRequest(
                                  _username.text, _password.text));
                        },
                        title: 'Sign In');
                  }
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator();
                  }

                  if (state is AuthResponseState) {
                    Text widget = const Text('');
                    state.response.fold((l) {
                      widget = Text(l);
                    }, (r) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => HomeBloc(),
                          child: HomeScreen(),
                        ),
                      ));
                    });
                    return widget;
                  }
                  return const Text('حطای نامشخص');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _username,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignupPage()));
              },
              child: const Text('Register Now'))
        ],
      ),
    );
  }
}
