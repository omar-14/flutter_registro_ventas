import 'package:intventory/features/auth/domain/domain.dart';

import '../infrastructure.dart';

class AuthRespositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRespositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String refresh) {
    return datasource.checkAuthStatus(refresh);
  }

  @override
  Future<User> login(String username, String password) {
    return datasource.login(username, password);
  }

  @override
  Future<User> register(Map<String, dynamic> likeUser) {
    return datasource.register(likeUser);
  }
}
