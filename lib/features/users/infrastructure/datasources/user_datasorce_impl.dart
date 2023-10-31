import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';
import 'package:intventory/features/users/domain/domain.dart';
import 'package:intventory/features/users/infrastructure/mappers/user_mapper.dart';

class UserDatasorceImpl extends UserDatasource {
  late final Dio dio;
  final String accessToken;

  UserDatasorceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {"Authorization": "Bearer $accessToken"}));

  @override
  Future<User> createUser(Map<String, dynamic> userLike) async {
    try {
      final response = await dio.post("/auth/register/", data: userLike);

      final newUser = UserMapper.jsonToEntity(response.data);

      return newUser;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteUser(String id) async {
    try {
      final response = await dio.delete("/users/$id/");

      return response.statusCode == 204;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      final response = await dio.get("/users/$id/");

      final user = UserMapper.jsonToEntity(response.data);

      return user;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<User>> listUsers({int limit = 10, int offset = 0}) async {
    try {
      final response = await dio.get(
        "/users/",
      );

      final List<User> users = [];

      for (final data in response.data ?? []) {
        final user = UserMapper.jsonToEntity(data);
        users.add(user);
      }

      return users;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> updateUser(Map<String, dynamic> userLike, String id) async {
    try {
      final response = await dio.patch("/users/$id/", data: userLike);

      final updateUser = UserMapper.jsonToEntity(response.data);

      return updateUser;
    } catch (e) {
      throw Exception();
    }
  }
}
