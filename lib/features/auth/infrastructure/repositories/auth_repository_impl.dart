import 'package:intventory/features/auth/domain/domain.dart';

import '../infrastructure.dart';

class AuthRespositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRespositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return datasource.register(email, password, fullName);
  }
}
