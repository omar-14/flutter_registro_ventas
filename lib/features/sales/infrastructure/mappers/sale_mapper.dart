import 'package:intventory/features/sales/domain/domain.dart';

class SaleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Sale(
      id: json["id"],
      isCompleted: json["is_completed"],
      user: json["user"],
      total: json["total"],
      createdAt: DateTime.parse(json["created_at"]));
}
