// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intventory/features/inventory/domain/domain.dart';

class DetailsSale {
  String id;
  String productQuantity;
  String productId;
  String subTotal;
  String idSale;
  DateTime createdAt;
  Product? product;

  DetailsSale(
      {required this.id,
      required this.productQuantity,
      required this.productId,
      required this.subTotal,
      required this.idSale,
      required this.createdAt,
      this.product});
}
