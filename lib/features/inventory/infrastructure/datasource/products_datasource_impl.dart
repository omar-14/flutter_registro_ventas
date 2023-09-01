import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {"Authorization": "Bearer $accessToken"}));

  @override
  Future<Product> createUpdateProducto(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProducto
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>("/products");

    final List<Product> products = [];

    for (final product in response.data ?? []) {
      final newProduct = ProductMapper.jsonToEntity(product);
      products.add(newProduct);
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
