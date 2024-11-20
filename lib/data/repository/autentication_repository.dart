import 'package:dartz/dartz.dart';
import 'package:flutter_spotify_app/DI/di.dart';
import 'package:flutter_spotify_app/data/datasorce/authentication_datasource.dart';
import 'package:flutter_spotify_app/utils/api_exeption/api_exeption.dart';
import 'package:flutter_spotify_app/utils/auth_manager.dart/auth_manager.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);
  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticationDataSource _dataSource = locator.get();
  // final SharedPreferences _sharepref = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _dataSource.register('mehran193', 'mehran123', 'mehran123');
      return right('ثیت نام انجام شد');
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا مختوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _dataSource.login(username, password);
      if (token.isNotEmpty) {
        AuthManager.savetoken(token);

        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش امده است');
      }
    } on ApiExeption catch (ex) {
      return left(ex.message ?? 'خطا مختوای متنی ندارد');
    }
  }
}
