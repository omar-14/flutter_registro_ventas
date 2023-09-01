import 'package:formz/formz.dart';

// Define input validation errors
enum KeyError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Key extends FormzInput<String, KeyError> {
  // Call super.pure to represent an unmodified form input.
  const Key.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Key.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == KeyError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  KeyError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return KeyError.empty;
    return null;
  }
}
