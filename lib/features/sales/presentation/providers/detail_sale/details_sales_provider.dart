import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/inventory/presentation/providers/providers.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final detailsSalesProvider = StateNotifierProvider.family<DetailsSalesNotifier,
    DetailsSalesState, String>((ref, id) {
  final detailsSalesRepository = ref.watch(detailsSalesRepositoryProvider);
  final productsRepository = ref.watch(productsRepositoryProvider);
  final saleState = ref.watch(saleProvider(id).notifier);
  final salesState = ref.watch(salesProvider.notifier);

  return DetailsSalesNotifier(
      detailsSalesRepository: detailsSalesRepository,
      saleState: saleState,
      salesState: salesState,
      id: id,
      productsRepository: productsRepository);
});

class DetailsSalesNotifier extends StateNotifier<DetailsSalesState> {
  final DetailsSalesRepository detailsSalesRepository;
  final ProductsRespository productsRepository;
  final SaleNotifier saleState;
  final SalesNotifier salesState;
  final String id;

  DetailsSalesNotifier(
      {required this.productsRepository,
      required this.detailsSalesRepository,
      required this.saleState,
      required this.salesState,
      required this.id})
      : super(DetailsSalesState()) {
    loadNextPage(id);
  }

  Future getDetailsSales(id) async {
    final detailsSales = await detailsSalesRepository.getDetailsSalesById(id,
        limit: state.limit, offset: state.offset);

    if (detailsSales.isEmpty) {
      return [];
    }

    for (final saleDetail in detailsSales) {
      final product =
          await productsRepository.getProductById(saleDetail.productId);

      saleDetail.product = product;
    }

    return detailsSales;
  }

  Future refreshPage() async {
    state = state.copyWith(offset: 0);
    salesState.state = salesState.state.copyWith(offset: 0);

    await saleState.loadSale();
    await salesState.refreshPage();
  }

  Future loadNextPage(String id) async {
    if (id.contains("new")) return;

    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final detailsSales = await getDetailsSales(id);

    if (detailsSales.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);

      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        detailsSales: [...state.detailsSales, ...detailsSales]);
  }

  Future createDetailSale(Map<String, dynamic> detailSaleLike) async {
    try {
      if (state.isLoading) return;

      state = state.copyWith(isLoading: true);

      final newDetailSale =
          await detailsSalesRepository.createDetailSale(detailSaleLike);

      final product =
          await productsRepository.getProductById(newDetailSale.productId);

      newDetailSale.product = product;

      state = state.copyWith(offset: 0);
      salesState.state = salesState.state.copyWith(offset: 0);

      await saleState.loadSale();
      await salesState.refreshPage();

      state = state.copyWith(
          isLoading: false,
          offset: state.offset + 10,
          detailsSales: [newDetailSale, ...state.detailsSales]);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception();
    }
  }

  Future deleteDetailProduct(String id) async {
    try {
      if (state.isLoading) return;

      state = state.copyWith(isLoading: true);

      final isDelete = await detailsSalesRepository.deleteDetailSale(id);

      if (!isDelete) return false;

      state.detailsSales.removeWhere((element) => element.id == id);

      await refreshPage();

      state = state.copyWith(isLoading: false);

      return isDelete;
    } catch (e) {
      throw Exception();
    }
  }

  Future updateQuantityDetailProduct(double quantity, String detailId) async {
    try {
      if (state.isLoading) return;

      state = state.copyWith(isLoading: true);

      final updateDetailProduct = await detailsSalesRepository
          .updateDetailSale({"product_quantity": quantity}, detailId);

      final product = await productsRepository
          .getProductById(updateDetailProduct.productId);

      updateDetailProduct.product = product;

      final index =
          state.detailsSales.indexWhere((element) => element.id == detailId);

      state.detailsSales[index] = updateDetailProduct;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      throw Exception();
    }
  }

  void onQuantityChanged(int quantity) {}
}

class DetailsSalesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<DetailsSale> detailsSales;

  DetailsSalesState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.detailsSales = const []});

  DetailsSalesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<DetailsSale>? detailsSales,
  }) =>
      DetailsSalesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        detailsSales: detailsSales ?? this.detailsSales,
      );
}
