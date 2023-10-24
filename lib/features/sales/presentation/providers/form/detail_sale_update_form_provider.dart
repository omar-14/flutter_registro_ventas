import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/shared/shared.dart';

final detailSaleUpdateFormProvider = StateNotifierProvider.family<
    DetailSaleUpdateFormNotifier,
    DetailSaleUpdateFormState,
    DetailsSale>((ref, detail) {
  // final detailsSalesRepository = ref.watch(detailsSalesRepositoryProvider);
  final updateCallback = ref
      .watch(detailsSalesProvider(detail.idSale).notifier)
      .updateQuantityDetailProduct;

  return DetailSaleUpdateFormNotifier(
      onSubmitCallback: updateCallback, detail: detail);
});

class DetailSaleUpdateFormNotifier
    extends StateNotifier<DetailSaleUpdateFormState> {
  final Future Function(double quantity, String id)? onSubmitCallback;
  final DetailsSale detail;

  DetailSaleUpdateFormNotifier({this.onSubmitCallback, required this.detail})
      : super(DetailSaleUpdateFormState(
            id: detail.id,
            quantity: Quantity.dirty(double.parse(detail.productQuantity))));

  Future<bool> onFormSubmit() async {
    _touchEverything();

    if (!state.isFormValid) return false;

    if (onSubmitCallback == null) return false;

    state = state.copyWith(isPosting: true);

    try {
      return await onSubmitCallback!(state.quantity.value, state.id);
    } catch (e) {
      return false;
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEverything() {
    state = state.copyWith(
        isFormPosted: true,
        isFormValid: Formz.validate([
          Quantity.dirty(state.quantity.value),
        ]));
  }

  void onQuantityChanged(double value) {
    state = state.copyWith(
        quantity: Quantity.dirty(value),
        isFormValid: Formz.validate([Quantity.dirty(value)]));
  }
}

class DetailSaleUpdateFormState {
  final bool isFormValid;
  final String id;
  final Quantity quantity;
  final bool isFormPosted;
  final bool isPosting;

  DetailSaleUpdateFormState(
      {this.isFormPosted = false,
      this.isPosting = false,
      this.isFormValid = false,
      required this.id,
      this.quantity = const Quantity.dirty(0)});

  DetailSaleUpdateFormState copyWith({
    bool? isFormValid,
    bool? isFormPosted,
    bool? isPosting,
    String? id,
    Quantity? quantity,
  }) =>
      DetailSaleUpdateFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
      );
}
