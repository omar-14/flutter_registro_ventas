import 'package:intventory/features/inventory/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRespository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Product> createProduct(Map<String, dynamic> productLike) {
    return datasource.createProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 50, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }

  @override
  Future<bool> deleteProduct(String id) {
    return datasource.deleteProduct(id);
  }

  @override
  Future<Product> updateProduct(Map<String, dynamic> productLike) {
    return datasource.updateProduct(productLike);
  }
}
