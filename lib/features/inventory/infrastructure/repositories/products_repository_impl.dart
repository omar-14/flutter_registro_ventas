import 'package:intventory/features/inventory/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRespository {
  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Product> createUpdateProducto(Map<String, dynamic> productLike) {
    return datasource.createUpdateProducto(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return datasource.searchProductByTerm(term);
  }
}
