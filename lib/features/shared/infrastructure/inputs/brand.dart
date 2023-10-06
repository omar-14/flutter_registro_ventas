import 'package:formz/formz.dart';

// Define input validation errors
enum BrandError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Brand extends FormzInput<String, BrandError> {
  // Call super.pure to represent an unmodified form input.
  const Brand.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Brand.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == BrandError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BrandError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return BrandError.empty;
    return null;
  }
}
