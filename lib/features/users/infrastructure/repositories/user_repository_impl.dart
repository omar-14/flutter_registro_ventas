import 'package:intventory/features/users/domain/domain.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDatasource datasource;

  UserRepositoryImpl(this.datasource);

  @override
  Future<User> createUser(Map<String, dynamic> userLike) {
    return datasource.createUser(userLike);
  }

  @override
  Future<bool> deleteUser(String id) {
    return datasource.deleteUser(id);
  }

  @override
  Future<User> getUserById(String id) {
    return datasource.getUserById(id);
  }

  @override
  Future<List<User>> listUsers({int limit = 10, int offset = 0}) {
    return datasource.listUsers();
  }

  @override
  Future<User> updateUser(Map<String, dynamic> userLike, String id) {
    return datasource.updateUser(userLike, id);
  }
}
