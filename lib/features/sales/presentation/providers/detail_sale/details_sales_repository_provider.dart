import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/infrastructure/infrastructure.dart';

final detailsSalesRepositoryProvider = Provider<DetailsSalesRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final detailsSalesRespository = DetailsSalesRepositoryImpl(
      DetailsSalesDatasourceImpl(accessToken: accessToken));

  return detailsSalesRespository;
});
