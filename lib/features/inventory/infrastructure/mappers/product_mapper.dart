import 'package:intventory/features/inventory/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json["id"],
        key: json["key"] ?? "",
        nameProduct: json["name"],
        brand: json["brand"],
        publicPrice: json["public_unit_price"],
        originalPrice: json["original_unit_price"],
        productProfit: json["product_profit_percentage"],
        stock: json["stock"],
        createdBy: json["created_by"],
        isSeasonProduct: json["is_season_product"],
        productType: json["product_type"],
        // createdAt: json["created_at"],
        // updatedAt: json["updated_at"]
      );
}
