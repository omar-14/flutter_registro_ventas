import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/shared/shared.dart';
import 'products_repository_provider.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  final keyValueStorageService = KeyValueStorageImpl();

  return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId,
      keyValueStorageService: keyValueStorageService);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRespository productsRepository;
  final KeyValueStorage keyValueStorageService;

  ProductNotifier(
      {required this.keyValueStorageService,
      required this.productsRepository,
      required String productId})
      : super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<Product> newEmptyProduct(String key) async {
    final String? user =
        await keyValueStorageService.getValue<String>("userId");

    return Product(
      id: "0",
      key: key,
      nameProduct: "",
      brand: "",
      publicPrice: "0",
      originalPrice: "0",
      productProfit: "0",
      stock: 0,
      createdBy: user ?? "",
      isSeasonProduct: false,
      productType: "",
    );
  }

  Future<void> loadProduct() async {
    try {
      if (state.id.contains("new")) {
        final List<String> idSplit = state.id.split("-");
        state = state.copyWith(
            isLoading: false,
            product:
                await newEmptyProduct(idSplit.length > 1 ? idSplit[1] : ""));
        return;
      }

      final product = await productsRepository.getProductById(state.id);

      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      throw Exception();
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
