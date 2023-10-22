import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/infrastructure/infrastructure.dart';

class SalesDatasourceImpl extends SalesDatasource {
  late final Dio dio;
  final String accessToken;

  SalesDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<Sale> createSale(Map<String, dynamic> saleLike) async {
    try {
      final response = await dio.post("/sales", data: saleLike);

      final Sale sale = SaleMapper.jsonToEntity(response.data);

      return sale;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteSale(String id) async {
    try {
      final response = await dio.delete("/sales/$id/");

      return response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Sale> getSaleById(String id) async {
    try {
      final response = await dio.get("/sales/$id");

      final Sale sale = SaleMapper.jsonToEntity(response.data);

      return sale;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Sale>> listSales({int limit = 10, int offset = 0}) async {
    try {
      final response = await dio.get("/sales/list",
          queryParameters: {"limit": limit, "offset": offset});

      final List<Sale> sales = [];

      for (final product in response.data ?? []) {
        final newSale = SaleMapper.jsonToEntity(product);
        sales.add(newSale);
      }

      return sales;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Sale>> listSalesByDate(
      {int limit = 10, int offset = 0, String date = ""}) async {
    try {
      final response = await dio.delete("/sales/",
          queryParameters: {"limit": limit, "offset": offset, "date": date});

      final List<Sale> sales = [];

      for (final sale in response.data ?? []) {
        final newSale = SaleMapper.jsonToEntity(sale);
        sales.add(newSale);
      }

      return sales;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Sale> updateSale(Map<String, dynamic> saleLike) async {
    try {
      final response =
          await dio.patch("/sales/${saleLike["id"]}/", data: saleLike);

      final Sale sale = SaleMapper.jsonToEntity(response.data);

      return sale;
    } catch (e) {
      throw Exception();
    }
  }
}
