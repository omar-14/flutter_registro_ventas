import 'package:formz/formz.dart';

// Define input validation errors
enum CreatedByError { empty, format }

// Extend FormzInput and provide the input type and error type.
class CreatedBy extends FormzInput<String, CreatedByError> {
  // Call super.pure to represent an unmodified form input.
  const CreatedBy.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CreatedBy.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CreatedByError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CreatedByError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CreatedByError.empty;
    return null;
  }
}
