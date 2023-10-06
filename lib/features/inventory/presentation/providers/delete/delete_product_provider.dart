import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/products_repository_provider.dart';

final deleteProductProvider = StateProvider<String>((ref) => '');

final deleteProductsProvider =
    StateNotifierProvider<DeleteProductNotifier, bool>((ref) {
  final productRepository = ref.read(productsRepositoryProvider);

  return DeleteProductNotifier(
      deleteProduct: productRepository.deleteProduct, ref: ref);
});

typedef DeleteProductCallback = Future<bool> Function(String id);

class DeleteProductNotifier extends StateNotifier<bool> {
  final DeleteProductCallback deleteProduct;
  final Ref ref;
  DeleteProductNotifier({required this.deleteProduct, required this.ref})
      : super(false);

  Future<bool> deleteProductById(String id) async {
    final bool product = await deleteProduct(id);

    // ref.read(deleteProdcutProvider.notifier).update((state) => id);

    // state = product;

    return product;
  }
}
