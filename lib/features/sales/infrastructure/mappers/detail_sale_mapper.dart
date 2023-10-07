import 'package:intventory/features/sales/domain/domain.dart';

class DetailSaleMapper {
  static jsonToEntity(Map<String, dynamic> json) => DetailsSale(
        id: json["id"],
        productQuantity: json["product_quantity"],
        idProduct: json["id_product"],
        subTotal: json["sub_total"],
        idSale: json["id_sale"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
