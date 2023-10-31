import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/users/infrastructure/infrastructure.dart';

class SaleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Sale(
      id: json["id"],
      isCompleted: json["is_completed"],
      userId: json["user"]["id"],
      user: UserMapper.jsonToEntity(json["user"]),
      total: double.parse(json["total"]),
      numberOfProducts: double.parse(json["number_of_products"]),
      createdAt: DateTime.parse(json["created_at"]));

  static jsonToEntityUpdate(Map<String, dynamic> json) => Sale(
      id: json["id"],
      isCompleted: json["is_completed"],
      userId: json["user"],
      total: double.parse(json["total"]),
      numberOfProducts: double.parse(json["number_of_products"]),
      createdAt: DateTime.parse(json["created_at"]));
}
