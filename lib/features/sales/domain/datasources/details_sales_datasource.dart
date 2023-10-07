import 'package:intventory/features/sales/domain/domain.dart';

abstract class DetailsSalesDatasource {
  Future<List<DetailsSale>> getDetailsSalesById(String id,
      {int limit = 10, int offset = 0});
  Future<DetailsSale> createDetailSale(Map<String, dynamic> detailSaleLike);
  Future<DetailsSale> updateDetailSale(Map<String, dynamic> detailSaleLike);
  Future<bool> deleteDetailSale(String id);
}
