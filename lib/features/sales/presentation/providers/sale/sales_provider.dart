import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final salesProvider = StateNotifierProvider<SalesNotifier, SalesState>((ref) {
  final salesRepository = ref.watch(salesRepositoryProvider);
  final authState = ref.read(authProvider);

  return SalesNotifier(salesRepository: salesRepository, authState: authState);
});

class SalesNotifier extends StateNotifier<SalesState> {
  final SalesRepository salesRepository;
  final AuthState authState;

  SalesNotifier({required this.authState, required this.salesRepository})
      : super(SalesState()) {
    loadNextPage();
  }

  Future refreshPage() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, offset: 0);

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
    final user = authState.user!.id;

    final emptySale = {
      "is_completed": false,
      "user": user,
      "total": 0,
      "number_of_products": 0,
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
  final bool isFinished;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Sale> sales;

  SalesState(
      {this.isLastPage = false,
      this.isFinished = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.sales = const []});

  SalesState copyWith({
    bool? isLastPage,
    bool? isFinished,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Sale>? sales,
  }) =>
      SalesState(
        isLastPage: isLastPage ?? this.isLastPage,
        isFinished: isFinished ?? this.isFinished,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        sales: sales ?? this.sales,
      );
}
