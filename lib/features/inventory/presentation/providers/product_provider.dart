import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'products_repository_provider.dart';
import 'package:uuid/uuid.dart';

final productQrIdProvider = StateProvider((ref) => "");

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  final authState = ref.read(authProvider);

  return ProductNotifier(
      productsRepository: productsRepository,
      productId: productId,
      authState: authState);
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRespository productsRepository;
  final AuthState authState;

  ProductNotifier(
      {required this.authState,
      required this.productsRepository,
      required String productId})
      : super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<Product> newEmptyProduct(String key) async {
    final user = authState.user!.id;

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

  Future getIdQr() async {
    try {
      state = state.copyWith(idQr: const Uuid().v4());
    } catch (e) {
      throw Exception();
    }
  }
}

class ProductState {
  final String id;
  final String idQr;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.idQr = "",
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    String? idQr,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
        id: id ?? this.id,
        idQr: idQr ?? this.idQr,
        product: product ?? this.product,
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
      );
}
