import 'package:dio/dio.dart';
import 'package:intventory/config/constants/environments.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/infrastructure/mappers/detail_sale_mapper.dart';

class DetailsSalesDatasourceImpl extends DetailsSalesDatasource {
  late final Dio dio;
  final String accessToken;

  DetailsSalesDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<bool> createDetailSale(Map<String, dynamic> detailSaleLike) async {
    try {
      final response = await dio.post("/sales-products", data: detailSaleLike);

      return response.statusCode == 201;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> deleteDetailSale(String id) async {
    try {
      final response = await dio.delete("/sales-products/$id/");

      return response.statusCode == 204;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<DetailsSale>> getDetailsSalesById(String id,
      {int limit = 10, int offset = 0}) async {
    try {
      final response = await dio.get("/list/sales-products",
          queryParameters: {"limit": limit, "offset": offset, "id": id});

      final List<DetailsSale> detailsSales = [];

      for (final detailSale in response.data ?? []) {
        final newDetailSale = DetailSaleMapper.jsonToEntity(detailSale);
        detailsSales.add(newDetailSale);
      }

      return detailsSales;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<DetailsSale> updateDetailSale(
      Map<String, dynamic> detailSaleLike, String id) async {
    try {
      final response =
          await dio.patch("/sales-products/$id/", data: detailSaleLike);

      final DetailsSale detailSale =
          DetailSaleMapper.jsonToEntity(response.data);

      return detailSale;
    } catch (e) {
      throw Exception();
    }
  }
}
