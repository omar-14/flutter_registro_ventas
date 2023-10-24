import 'package:formz/formz.dart';

// Define input validation errors
enum SeasonProductError { empty, format }

// Extend FormzInput and provide the input type and error type.
class SeasonProduct extends FormzInput<String, SeasonProductError> {
  // Call super.pure to represent an unmodified form input.
  const SeasonProduct.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const SeasonProduct.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SeasonProductError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SeasonProductError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return SeasonProductError.empty;
    return null;
  }
}
