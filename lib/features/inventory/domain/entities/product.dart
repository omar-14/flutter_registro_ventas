// import '../../../auth/domain/domain.dart';

class Product {
  String id;
  String key;
  String nameProduct;
  String brand;
  String publicPrice;
  String originalPrice;
  String productProfit;
  int stock;
  String createdBy;
  bool isSeasonProduct;
  String productType;
  // DateTime createdAt;
  // DateTime updatedAt;

  // String slug;
  // List<String> images;
  // User? user;

  Product({
    required this.id,
    required this.key,
    required this.nameProduct,
    required this.brand,
    required this.publicPrice,
    required this.originalPrice,
    required this.productProfit,
    required this.stock,
    required this.createdBy,
    required this.isSeasonProduct,
    required this.productType,
    // required this.createdAt,
    // required this.updatedAt,
  });
}
