import 'package:formz/formz.dart';

// Define input validation errors
enum ProfitError { empty, value }

// Extend FormzInput and provide the input type and error type.
class Profit extends FormzInput<String, ProfitError> {
  // Call super.pure to represent an unmodified form input.
  const Profit.pure() : super.pure("0");

  // Call super.dirty to represent a modified form input.
  const Profit.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == ProfitError.empty) return 'El campo es requerido';
    // if (displayError == ProfitError.value) {
    //   return 'Tiene que ser un nùmero mayor o igual a 0';
    // }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  ProfitError? validator(String value) {
    if (value.toString().isEmpty || value.toString().trim().isEmpty) {
      return ProfitError.empty;
    }
    // if (value < 0) return ProfitError.value;

    return null;
  }
}
