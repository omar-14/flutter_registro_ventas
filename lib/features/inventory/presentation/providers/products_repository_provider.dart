import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/infrastructure/infrastructure.dart';

final productsRepositoryProvider = Provider<ProductsRespository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRespository =
      ProductsRepositoryImpl(ProductsDatasourceImpl(accessToken: accessToken));

  return productsRespository;
});
