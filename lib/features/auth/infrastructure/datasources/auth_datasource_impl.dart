import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';

import 'package:intventory/features/auth/domain/domain.dart';
import 'package:intventory/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get("/auth/check-status",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError("Token Incorrecto");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError("Revisar conecxión a internet");
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final resposne = await dio
          .post("/auth/login", data: {"username": email, "password": password});
      final user = UserMapper.userJsonToEntity(resposne.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data["message"] ?? "Credenciales incorrectas");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError("Revisar conecxión a internet");
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
