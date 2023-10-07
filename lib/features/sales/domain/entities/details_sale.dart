// ignore_for_file: public_member_api_docs, sort_constructors_first

class DetailsSale {
  String id;
  int productQuantity;
  String idProduct;
  String subTotal;
  String idSale;
  DateTime createdAt;

  DetailsSale({
    required this.id,
    required this.productQuantity,
    required this.idProduct,
    required this.subTotal,
    required this.idSale,
    required this.createdAt,
  });
}
