import '../../../../../../utils/manager/extensions/custom_string_extensions.dart';

class LoginRequestParams {
  final String email;
  final String password;
  final String appToken;

  const LoginRequestParams({
    required this.email,
    required this.password,
    this.appToken = "",
  });

  Map<String, dynamic> get toJson => {
    "email": email,
    "password": password,
    if (appToken.isNullOrEmpty) "app_token": appToken,
  };
}
