import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';

import 'package:intventory/features/auth/domain/domain.dart';
import 'package:intventory/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<User> checkAuthStatus(String refresh) async {
    try {
      final response =
          await dio.post("/auth/refresh/", data: {"refresh": refresh});

      final user = UserMapper.userJsonToEntityAuth(response.data);
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
  Future<User> login(String username, String password) async {
    try {
      final resposne = await dio.post("/auth/login/",
          data: {"username": username, "password": password});

      final user = UserMapper.userJsonToEntityAuth(resposne.data);
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
  Future<User> register(Map<String, dynamic> likeUser) async {
    try {
      final resposne = await dio.post("/auth/register/", data: likeUser);

      final user = UserMapper.userJsonToEntityAuth(resposne.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data["message"] ?? "Error con el registro");
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError("Revisar conecxión a internet");
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
