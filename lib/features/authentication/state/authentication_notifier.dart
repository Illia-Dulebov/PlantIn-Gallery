import 'package:flutter/cupertino.dart';
import 'package:gallery/features/authentication/models/auth_status.dart';
import 'package:gallery/features/authentication/repositories/dio_auth_repository.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final DioAuthRepository _repository;

  AuthenticationNotifier(this._repository);

  AuthStatus _authStatus = AuthStatus.unknown;
  AuthStatus get authStatus => _authStatus;

  void logOut() {
    _repository.deleteToken();
    notifyListeners();
  }

  Future<bool> logIn(String email, String password) async {
    _authStatus = AuthStatus.loggingIn;
    notifyListeners();

    final result = await _repository.login(email: email, password: password);
    notifyListeners();

    _authStatus = AuthStatus.loggingResult;
    notifyListeners();
    return result;
  }

  void checkAuthentication() async {
   _authStatus = AuthStatus.checking;
    notifyListeners();

    final token = await _repository.getToken();
    _authStatus = token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }
}