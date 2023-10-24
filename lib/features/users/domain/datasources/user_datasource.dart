import 'package:intventory/features/users/domain/domain.dart';

abstract class UserDatasource {
  Future<List<User>> listUsers({int limit = 10, int offset = 0});
  Future<User> getUserById(String id);
  Future<User> createUser(Map<String, dynamic> userLike);
  Future<User> updateUser(Map<String, dynamic> userLike, String id);
  Future<bool> deleteUser(String id);
}
