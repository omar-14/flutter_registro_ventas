import 'package:formz/formz.dart';

// Define input validation errors
enum PublicPriceError { empty, format }

// Extend FormzInput and provide the input type and error type.
class PublicPrice extends FormzInput<String, PublicPriceError> {
  // Call super.pure to represent an unmodified form input.
  const PublicPrice.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PublicPrice.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PublicPriceError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PublicPriceError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PublicPriceError.empty;
    return null;
  }
}
