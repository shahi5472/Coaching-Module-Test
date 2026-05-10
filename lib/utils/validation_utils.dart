import 'package:email_validator/email_validator.dart';

class ValidationUtils {
  static bool isEmailValid(String? email) {
    return email != null && EmailValidator.validate(email);
  }
}
