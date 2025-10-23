abstract interface class AuthRepository {
  Future<bool> login({required String email, required String password});

  Future<bool> saveToken({required String token});

  Future<bool> deleteToken();

  Future<String?> getToken();
}
