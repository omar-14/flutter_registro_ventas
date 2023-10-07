import 'package:intventory/features/sales/domain/domain.dart';

abstract class SalesDatasource {
  Future<List<Sale>> listSales({int limit = 10, int offset = 0});
  Future<List<Sale>> listSalesByDate(
      {int limit = 10, int offset = 0, String date = ""});
  Future<Sale> getSaleById(String id);
  Future<Sale> createSale(Map<String, dynamic> saleLike);
  Future<Sale> updateSale(Map<String, dynamic> saleLike);
  Future<bool> deleteSale(String id);
}
