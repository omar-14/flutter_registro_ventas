import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailSaleFormNotifier extends StateNotifier<DetailSaleFormState> {
  DetailSaleFormNotifier(super.state);
}

class DetailSaleFormState {
  final bool isFormValid;
  final String? id;
  final int quantity;

  DetailSaleFormState({this.isFormValid = false, this.id, this.quantity = 0});

  DetailSaleFormState copyWith({
    bool? isFormValid,
    String? id,
    int? quantity,
  }) =>
      DetailSaleFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
      );
}
