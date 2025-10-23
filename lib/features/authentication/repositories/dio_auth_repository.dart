import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:gallery/features/authentication/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioAuthRepository implements AuthRepository {
  DioAuthRepository(this.dio, this.localStorage);

  final Dio dio;
  final SharedPreferences localStorage;

  @override
  Future<bool> saveToken({required String token}) async {
    return await localStorage.setString('token', token);
  }

  @override
  Future<bool> deleteToken() async {
    return await localStorage.remove('token');
  }

  @override
  Future<String?> getToken() async {
    return localStorage.getString('token');
  }

  @override
  Future<bool> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'test' && password == '1111') {
      final tokenSource = '$email:$password:${DateTime.now().millisecondsSinceEpoch}';
      final bytes = utf8.encode(tokenSource);
      final hash = sha256.convert(bytes);
      final fakeToken = base64Url.encode(hash.bytes);

      await saveToken(token: fakeToken);

      return true;
    }

    return false;
  }
}