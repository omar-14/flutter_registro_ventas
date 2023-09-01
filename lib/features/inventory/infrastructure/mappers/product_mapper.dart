import 'package:intventory/features/inventory/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
        id: json["id"],
        key: json["key"],
        name: json["name"],
        brand: json["brand"],
        publicUnitPrice: json["public_unit_price"],
        originalUnitPrice: json["original_unit_price"],
        stock: json["stock"],
        createdBy: json["created_by"],
        isSeasonProduct: json["is_season_product"],
        productType: json["product_type"],
        // createdAt: json["created_at"],
        // updatedAt: json["updated_at"]
      );
}
