import 'package:formz/formz.dart';

// Define input validation errors
enum ProductTypeError { empty, format }

// Extend FormzInput and provide the input type and error type.
class ProductType extends FormzInput<String, ProductTypeError> {
  // Call super.pure to represent an unmodified form input.
  const ProductType.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ProductType.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ProductTypeError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ProductTypeError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return ProductTypeError.empty;
    return null;
  }
}
