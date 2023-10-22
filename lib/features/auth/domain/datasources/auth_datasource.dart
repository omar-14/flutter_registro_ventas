import '../entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String username, String password);
  Future<User> register(Map<String, dynamic> likeUser);
  Future<User> checkAuthStatus(String refresh);
}
