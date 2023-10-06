import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/products_repository_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProductsProvider =
    StateNotifierProvider<SearchProductNotifier, List<Product>>((ref) {
  final productRepository = ref.read(productsRepositoryProvider);

  return SearchProductNotifier(
      searchProduct: productRepository.searchProductByTerm, ref: ref);
});

typedef SearchProductCallback = Future<List<Product>> Function(String query);

class SearchProductNotifier extends StateNotifier<List<Product>> {
  final SearchProductCallback searchProduct;
  final Ref ref;
  SearchProductNotifier({required this.searchProduct, required this.ref})
      : super([]);

  Future<List<Product>> searchMoviesByQuery(String query) async {
    final List<Product> product = await searchProduct(query);

    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = product;

    return product;
  }

  Future<Product> searchProductByKey(String key) async {
    final List<Product> products = await searchProduct(key);

    ref.read(searchQueryProvider.notifier).update((state) => key);

    state = products;

    return products.isEmpty
        ? Product(
            id: "new",
            key: "",
            nameProduct: "",
            brand: "",
            publicPrice: "",
            originalPrice: "",
            productProfit: "",
            stock: 0,
            createdBy: "",
            isSeasonProduct: false,
            productType: "")
        : products.first;
  }
}
