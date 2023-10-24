import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
// import 'package:intventory/features/sales/domain/domain.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/shared/shared.dart';

final detailSaleCreateFormProvider = StateNotifierProvider.family<
    DetailSaleCreateFormNotifier,
    DetailSaleCreateFormState,
    String>((ref, idSale) {
  // final detailsSalesRepository = ref.watch(detailsSalesRepositoryProvider);
  final updateCallback =
      ref.watch(detailsSalesProvider(idSale).notifier).createDetailSale;

  return DetailSaleCreateFormNotifier(
      onSubmitCallback: updateCallback, idSale: idSale);
});

class DetailSaleCreateFormNotifier
    extends StateNotifier<DetailSaleCreateFormState> {
  final Future Function(Map<String, dynamic> detailSaleLike)? onSubmitCallback;
  final String idSale;

  DetailSaleCreateFormNotifier({this.onSubmitCallback, required this.idSale})
      : super(DetailSaleCreateFormState(
            id: idSale, quantity: const Quantity.dirty(0)));

  Future<bool> onFormSubmit(Product product) async {
    _touchEverything();

    if (!state.isFormValid) return false;

    if (state.isPosting) return false;

    if (onSubmitCallback == null) return false;

    state = state.copyWith(isPosting: true);

    final newDetail = {
      "id_product": product.id,
      "id_sale": idSale,
      "sub_total": product.publicPrice,
      "product_quantity": state.quantity.value
    };

    try {
      return await onSubmitCallback!(newDetail);
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

class DetailSaleCreateFormState {
  final bool isFormValid;
  final String id;
  final Quantity quantity;
  final bool isFormPosted;
  final bool isPosting;

  DetailSaleCreateFormState(
      {this.isFormPosted = false,
      this.isPosting = false,
      this.isFormValid = false,
      required this.id,
      this.quantity = const Quantity.dirty(0)});

  DetailSaleCreateFormState copyWith({
    bool? isFormValid,
    bool? isFormPosted,
    bool? isPosting,
    String? id,
    Quantity? quantity,
  }) =>
      DetailSaleCreateFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
      );
}
