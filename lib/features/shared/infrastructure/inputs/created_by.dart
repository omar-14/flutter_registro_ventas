import 'package:formz/formz.dart';

// Define input validation errors
enum CreateByError { empty, format }

// Extend FormzInput and provide the input type and error type.
class CreateBy extends FormzInput<String, CreateByError> {
  // Call super.pure to represent an unmodified form input.
  const CreateBy.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CreateBy.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CreateByError.empty) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CreateByError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return CreateByError.empty;
    return null;
  }
}
