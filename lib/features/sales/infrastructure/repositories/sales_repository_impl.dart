import 'package:intventory/features/sales/domain/domain.dart';

class SalesRepositoryImpl extends SalesRepository {
  final SalesDatasource datasource;

  SalesRepositoryImpl(this.datasource);

  @override
  Future<Sale> createSale(Map<String, dynamic> saleLike) {
    return datasource.createSale(saleLike);
  }

  @override
  Future<bool> deleteSale(String id) {
    return datasource.deleteSale(id);
  }

  @override
  Future<Sale> getSaleById(String id) {
    return datasource.getSaleById(id);
  }

  @override
  Future<List<Sale>> listSales({int limit = 10, int offset = 0}) {
    return datasource.listSales(limit: limit, offset: offset);
  }

  @override
  Future<List<Sale>> listSalesByDate(
      {int limit = 10, int offset = 0, String date = ""}) {
    return datasource.listSalesByDate(limit: limit, offset: offset, date: date);
  }

  @override
  Future<Sale> updateSale(Map<String, dynamic> saleLike) {
    return datasource.updateSale(saleLike);
  }
}
