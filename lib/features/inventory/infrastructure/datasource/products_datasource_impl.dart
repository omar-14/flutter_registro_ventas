import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/infrastructure/errors/product_errors.dart';
import 'package:intventory/features/inventory/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          // headers: {"Authorization": "Bearer $accessToken"}
        ));

  @override
  Future<Product> createUpdateProducto(Map<String, dynamic> productLike) async {
    try {
      final response = await dio.post("/products/", data: productLike);

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await dio.get("/products/$id/");

      final product = ProductMapper.jsonToEntity(response.data);

      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>("/products/search");

    final List<Product> products = [];

    for (final product in response.data ?? []) {
      final newProduct = ProductMapper.jsonToEntity(product);
      products.add(newProduct);
    }

    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) async {
    final response = await dio.get("/products/search/");

    final List<Product> products = [];

    for (final product in response.data ?? []) {
      final newProduct = ProductMapper.jsonToEntity(product);
      products.add(newProduct);
    }

    return products;
  }
}
