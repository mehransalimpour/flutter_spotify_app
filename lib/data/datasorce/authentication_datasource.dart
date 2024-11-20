import 'package:dio/dio.dart';
import 'package:flutter_spotify_app/DI/di.dart';
import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';

abstract class IAuthenticationDataSource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationRemote implements IAuthenticationDataSource {
  final Dio _dio = locator.get();
  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      // final response = await _dio.post('collections/users/records', data: {
      //   'username': username,
      //   'password': password,
      //   'passwordConfirm': passwordConfirm
      // });
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unkwon error');
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post('collections/users/auth-with-password',
          data: {'identity': username, 'password': password});
      if (response.statusCode == 200) {
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiExeption(ex.response?.statusCode, ex.response?.data['message']);
    } catch (e) {
      throw ApiExeption(0, 'unkwon error');
    }
    return '';
  }
}
