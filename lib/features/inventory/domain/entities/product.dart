// import '../../../auth/domain/domain.dart';

class Product {
  String id;
  String key;
  String name;
  String brand;
  String publicUnitPrice;
  String originalUnitPrice;
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
    required this.name,
    required this.brand,
    required this.publicUnitPrice,
    required this.originalUnitPrice,
    required this.stock,
    required this.createdBy,
    required this.isSeasonProduct,
    required this.productType,
    // required this.createdAt,
    // required this.updatedAt,
  });
}
