// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:formz/formz.dart';
// import 'package:intventory/features/inventory/domain/domain.dart';
// // import 'package:intventory/features/sales/domain/domain.dart';
// import 'package:intventory/features/sales/presentation/providers/providers.dart';
// import 'package:intventory/features/shared/shared.dart';

// final detailSaleIdProvider = StateProvider<String>((ref) => "");

// final detailSaleFormProvider = StateNotifierProvider.family<
//     DetailSaleFormNotifier, DetailSaleFormState, String>((ref, idSale) {
//   final detailSaleId = ref.watch(detailSaleIdProvider);
//   final createCallback =
//       ref.watch(detailsSalesProvider(idSale).notifier).createDetailSale;

//   final updateCallback = ref
//       .watch(detailsSalesProvider(idSale).notifier)
//       .updateQuantityDetailProduct;

//   return DetailSaleFormNotifier(
//       onSubmitCreateCallback: createCallback,
//       onSubmitUpdateCallback: updateCallback,
//       detailSaleId: detailSaleId,
//       idSale: idSale);
// });

// class DetailSaleFormNotifier extends StateNotifier<DetailSaleFormState> {
//   final Future<dynamic> Function(Map<String, dynamic> detailSaleLike)?
//       onSubmitCreateCallback;

//   final Future Function(double quantity, String id)? onSubmitUpdateCallback;
//   final String detailSaleId;
//   final String idSale;

//   DetailSaleFormNotifier(
//       {this.onSubmitCreateCallback,
//       this.onSubmitUpdateCallback,
//       required this.detailSaleId,
//       required this.idSale})
//       : super(DetailSaleFormState(
//             id: idSale, quantity: Quantity.dirty(state.quantity.value)));

//   Future<bool> onFormSubmit(Product? product) async {
//     _touchEverything();

//     if (!state.isFormValid) return false;

//     if (onSubmitCreateCallback == null) return false;
//     if (onSubmitUpdateCallback == null) return false;

//     state = state.copyWith(isPosting: true);

//     if (product != null) {
//       final newDetail = {
//         "id_product": product.id,
//         "id_sale": idSale,
//         "sub_total": product.publicPrice,
//         "product_quantity": state.quantity.value
//       };

//       try {
//         return await onSubmitCreateCallback!(newDetail);
//       } catch (e) {
//         return false;
//       } finally {
//         state = state.copyWith(isPosting: false);
//       }
//     } else {
//       try {
//         return await onSubmitUpdateCallback!(
//             state.quantity.value, detailSaleId);
//       } catch (e) {
//         return false;
//       } finally {
//         state = state.copyWith(isPosting: false);
//       }
//     }
//   }

//   void _touchEverything() {
//     state = state.copyWith(
//         isFormPosted: true,
//         isFormValid: Formz.validate([
//           Quantity.dirty(state.quantity.value),
//         ]));
//   }

//   Future<void> onQuantityChanged(double value) async {
//     state = state.copyWith(
//         quantity: Quantity.dirty(value),
//         isFormValid: Formz.validate([Quantity.dirty(value)]));
//   }
// }

// class DetailSaleFormState {
//   final bool isFormValid;
//   final String id;
//   final Quantity quantity;
//   final bool isFormPosted;
//   final bool isPosting;

//   DetailSaleFormState(
//       {this.isFormPosted = false,
//       this.isPosting = false,
//       this.isFormValid = false,
//       required this.id,
//       this.quantity = const Quantity.dirty(0)});

//   DetailSaleFormState copyWith({
//     bool? isFormValid,
//     bool? isFormPosted,
//     bool? isPosting,
//     String? id,
//     Quantity? quantity,
//   }) =>
//       DetailSaleFormState(
//         isPosting: isPosting ?? this.isPosting,
//         isFormPosted: isFormPosted ?? this.isFormPosted,
//         isFormValid: isFormValid ?? this.isFormValid,
//         id: id ?? this.id,
//         quantity: quantity ?? this.quantity,
//       );
// }
