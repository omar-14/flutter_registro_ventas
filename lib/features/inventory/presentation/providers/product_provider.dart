import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'products_repository_provider.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
      productsRepository: productsRepository, productId: productId);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRespository productsRepository;

  ProductNotifier({required this.productsRepository, required String productId})
      : super(ProductState(id: productId)) {
    loadProduct();
  }

  Product newEmptyProduct() {
    return Product(
      id: "0",
      key: "",
      nameProduct: "",
      brand: "",
      publicPrice: "0",
      originalPrice: "0",
      productProfit: "0",
      stock: 0,
      createdBy: "3695dc2a-3dc6-4bba-9a1a-5bec54bc0391",
      isSeasonProduct: false,
      productType: "",
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == "new") {
        state = state.copyWith(isLoading: false, product: newEmptyProduct());
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
