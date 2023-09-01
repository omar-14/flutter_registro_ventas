import '../entities/product.dart';

abstract class ProductsRespository {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);

  Future<List<Product>> searchProductByTerm(String term);
  Future<Product> createUpdateProducto(Map<String, dynamic> productLike);
}
