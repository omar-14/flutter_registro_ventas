import 'package:intventory/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        // role: json["role"],
        token: json["token"] ?? "",
        refresh: json["refresh"] ?? "",
      );
}
