import 'package:intventory/features/sales/domain/domain.dart';

class SaleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Sale(
      id: json["id"],
      isComplete: json["isComplete"],
      user: json["user"],
      total: json["total"]);
}
