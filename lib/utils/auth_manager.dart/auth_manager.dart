import 'package:flutter/material.dart';
import 'package:flutter_spotify_app/DI/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _preferences = locator.get();
  static void savetoken(String token) async {
    _preferences.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static String readAuth() {
    return _preferences.getString('access_token') ?? '';
  }

  static void logautAuth() {
    _preferences.clear();
    authChangeNotifier.value = null;
  }

  static bool islogin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
