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
  Future<DetailsSale> createDetailSale(Map<String, dynamic> detailSaleLike) {
    // TODO: implement createDetailSale
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteDetailSale(String id) {
    // TODO: implement deleteDetailSale
    throw UnimplementedError();
  }

  @override
  Future<List<DetailsSale>> getDetailsSalesById(String id,
      {int limit = 10, int offset = 0}) async {
    try {
      final response = await dio.get(
        "/sales-products/",
      );

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
  Future<DetailsSale> updateDetailSale(Map<String, dynamic> detailSaleLike) {
    // TODO: implement updateDetailSale
    throw UnimplementedError();
  }
}
