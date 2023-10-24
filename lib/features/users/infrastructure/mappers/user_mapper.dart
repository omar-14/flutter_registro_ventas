import 'package:intventory/features/users/domain/domain.dart';

class UserMapper {
  static jsonToEntity(Map<String, dynamic> json) => User(
      id: json["id"],
      username: json["username"],
      fistName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      role: json["role"]);
}
