import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final salesProvider =
    StateNotifierProvider.autoDispose<SalesNotifier, SalesState>((ref) {
  final salesRepository = ref.watch(salesRepositoryProvider);

  return SalesNotifier(salesRepository: salesRepository);
});

class SalesNotifier extends StateNotifier<SalesState> {
  final SalesRepository salesRepository;

  SalesNotifier({required this.salesRepository}) : super(SalesState()) {
    loadNextPage();
  }

  Future refreshPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final sales = await salesRepository.listSales(
        limit: state.limit, offset: state.offset);

    if (sales.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);

      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        sales: sales);
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final sales = await salesRepository.listSales(
        limit: state.limit, offset: state.offset);

    if (sales.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);

      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        sales: [...state.sales, ...sales]);
  }

  Future createSale() async {
    final emptySale = {
      "is_completed": false,
      "user": "c2e19368-7e38-4875-9a6f-57b03e17b636",
      "total": 0
    };
    final newSale = await salesRepository.createSale(emptySale);

    state = state.copyWith(isLoading: false, sales: [newSale, ...state.sales]);

    return newSale;
  }

  Future<bool> deleteSale(id) async {
    try {
      final isDelete = await salesRepository.deleteSale(id);

      if (!isDelete) return false;

      state.sales.removeWhere((element) => element.id == id);

      return isDelete;
    } catch (e) {
      throw Exception();
    }
  }
}

class SalesState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Sale> sales;

  SalesState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.sales = const []});

  SalesState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Sale>? sales,
  }) =>
      SalesState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        sales: sales ?? this.sales,
      );
}
