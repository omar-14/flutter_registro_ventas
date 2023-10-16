import 'package:intventory/features/sales/domain/domain.dart';
// import 'package:intventory/features/auth/infrastructure/infrastructure.dart';

class SaleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Sale(
      id: json["id"],
      isCompleted: json["is_completed"],
      userId: json["user"],
      total: json["total"],
      createdAt: DateTime.parse(json["created_at"]));
}
