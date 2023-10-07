import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/infrastructure/infrastructure.dart';

final salesRepositoryProvider = Provider<SalesRepository>((ref) {
  // final accessToken = ref.watch(authProvider).user?.token ?? '';

  final salesRespository =
      SalesRepositoryImpl(SalesDatasourceImpl(accessToken: ''));

  return salesRespository;
});
