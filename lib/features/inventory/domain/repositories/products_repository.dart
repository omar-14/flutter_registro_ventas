import '../entities/product.dart';

abstract class ProductsRespository {
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Product> getProductById(String id);

  Future<List<Product>> searchProductByTerm(String term);
  Future<Product> createProduct(Map<String, dynamic> productLike);
  Future<Product> updateProduct(Map<String, dynamic> productLike);
  Future<bool> deleteProduct(String id);
}
