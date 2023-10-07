import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';

final detailsSalesProvider = StateNotifierProvider.autoDispose
    .family<DetailsSalesNotifier, DetailsSalesState, String>((ref, id) {
  final detailsSalesRepository = ref.watch(detailsSalesRepositoryProvider);

  return DetailsSalesNotifier(
      detailsSalesRepository: detailsSalesRepository, id: id);
});

class DetailsSalesNotifier extends StateNotifier<DetailsSalesState> {
  final DetailsSalesRepository detailsSalesRepository;
  final String id;

  DetailsSalesNotifier({required this.detailsSalesRepository, required this.id})
      : super(DetailsSalesState()) {
    loadNextPage(id);
  }

  Future loadNextPage(String id) async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final detailsSales = await detailsSalesRepository.getDetailsSalesById(id,
        limit: state.limit, offset: state.offset);

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
