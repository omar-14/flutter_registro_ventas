import 'package:intventory/features/sales/domain/domain.dart';
// import 'package:intventory/features/sales/infrastructure/datasources/details_sales_datasource_impl.dart';

class DetailsSalesRepositoryImpl extends DetailsSalesRepository {
  final DetailsSalesDatasource datasource;

  DetailsSalesRepositoryImpl(this.datasource);

  @override
  Future<DetailsSale> createDetailSale(Map<String, dynamic> detailSaleLike) {
    return datasource.createDetailSale(detailSaleLike);
  }

  @override
  Future<bool> deleteDetailSale(String id) {
    return datasource.deleteDetailSale(id);
  }

  @override
  Future<List<DetailsSale>> getDetailsSalesById(String id,
      {int limit = 10, int offset = 0}) {
    return datasource.getDetailsSalesById(id, limit: limit, offset: offset);
  }

  @override
  Future<DetailsSale> updateDetailSale(Map<String, dynamic> detailSaleLike) {
    return datasource.updateDetailSale(detailSaleLike);
  }
}
