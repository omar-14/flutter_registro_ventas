import 'package:formz/formz.dart';

// Define input validation errors
enum QuantityError { empty, value, format }

// Extend FormzInput and provide the input type and error type.
class Quantity extends FormzInput<double, QuantityError> {
  // Call super.pure to represent an unmodified form input.
  const Quantity.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Quantity.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == QuantityError.empty) return 'El campo es requerido';
    if (displayError == QuantityError.value) {
      return 'Tiene que ser un nùmero mayor o igual a 0';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  QuantityError? validator(double value) {
    if (value.toString().isEmpty ||
        value.toString().trim().isEmpty ||
        value == -1) {
      return QuantityError.empty;
    }

    final isDouble = double.tryParse(value.toString()) ?? -1;

    if (isDouble == -1) return QuantityError.format;

    if (value <= 0) {
      return QuantityError.value;
    }

    return null;
  }
}
