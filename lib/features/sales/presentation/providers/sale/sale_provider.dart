import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intventory/features/auth/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final saleProvider =
    StateNotifierProvider.family<SaleNotifier, SaleState, String>(
        (ref, saleId) {
  final salesRepository = ref.watch(salesRepositoryProvider);

  return SaleNotifier(salesRepository: salesRepository, saleId: saleId);
});

class SaleNotifier extends StateNotifier<SaleState> {
  final SalesRepository salesRepository;

  SaleNotifier({required this.salesRepository, required String saleId})
      : super(SaleState(id: saleId)) {
    loadSale();
  }

  Sale newEmptySale() {
    return Sale(id: "", isCompleted: false, userId: "", total: 0);
  }

  Future<void> loadSale() async {
    try {
      final sale = await salesRepository.getSaleById(state.id);

      state = state.copyWith(isLoading: false, sale: sale);
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
