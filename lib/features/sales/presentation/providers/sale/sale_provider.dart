// import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intventory/features/auth/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final saleProvider =
    StateNotifierProvider.family<SaleNotifier, SaleState, String>(
        (ref, saleId) {
  final salesRepository = ref.watch(salesRepositoryProvider);

  final salesState = ref.read(salesProvider.notifier);

  return SaleNotifier(
      salesRepository: salesRepository, salesState: salesState, saleId: saleId);
});

class SaleNotifier extends StateNotifier<SaleState> {
  final SalesRepository salesRepository;
  final SalesNotifier salesState;

  SaleNotifier(
      {required this.salesState,
      required this.salesRepository,
      required String saleId})
      : super(SaleState(id: saleId)) {
    loadSale();
  }

  Sale newEmptySale() {
    return Sale(
        id: "", isCompleted: false, userId: "", total: 0, numberOfProducts: 0);
  }

  Future<void> loadSale() async {
    try {
      final sale = await salesRepository.getSaleById(state.id);

      state = state.copyWith(isLoading: false, sale: sale);
    } catch (e) {
      throw Exception();
    }
  }

  Future updateSale(Map<String, dynamic> saleLike) async {
    try {
      if (state.isLoading) return;

      state = state.copyWith(isLoading: true);

      final updateSale = await salesRepository.updateSale(saleLike);

      final index = salesState.state.sales
          .indexWhere((element) => element.id == state.id);

      salesState.state.sales[index] = updateSale;

      loadSale();

      state = state.copyWith(isLoading: false);
    } catch (e) {
      throw Exception();
    }
  }
}

class SaleState {
  final bool isLoading;
  final bool isSaving;
  final String id;
  final Sale? sale;

  SaleState(
      {required this.id,
      this.isSaving = true,
      this.isLoading = false,
      this.sale});

  SaleState copyWith({
    bool? isLoading,
    bool? isSaving,
    String? id,
    Sale? sale,
  }) =>
      SaleState(
        isLoading: isLoading ?? this.isLoading,
        isSaving: isSaving ?? this.isSaving,
        id: id ?? this.id,
        sale: sale ?? this.sale,
      );
}
