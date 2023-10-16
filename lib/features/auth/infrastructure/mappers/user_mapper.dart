import 'package:intventory/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntityAuth(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        token: json["token"] ?? "",
        refresh: json["refresh"] ?? "",
      );

  static User userJsonToEntity(Map<String, dynamic> json) => User(
      id: json["id"],
      email: json["email"],
      username: json["username"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      role: json["role"]);
}
