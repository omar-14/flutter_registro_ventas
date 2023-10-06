import 'package:formz/formz.dart';

// Define input validation errors
enum OriginalPriceError { empty, value }

// Extend FormzInput and provide the input type and error type.
class OriginalPrice extends FormzInput<String, OriginalPriceError> {
  // Call super.pure to represent an unmodified form input.
  const OriginalPrice.pure() : super.pure("0");

  // Call super.dirty to represent a modified form input.
  const OriginalPrice.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == OriginalPriceError.empty)
      return 'El campo es requerido';
    // if (displayError == OriginalPriceError.value) {
    //   return 'Tiene que ser un nùmero mayor o igual a 0';
    // }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  OriginalPriceError? validator(String value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return OriginalPriceError.empty;
    }
    // if (value < 0) return OriginalPriceError.value;

    return null;
  }
}
