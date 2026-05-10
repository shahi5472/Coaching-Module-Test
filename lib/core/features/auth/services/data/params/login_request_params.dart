import '../../../../../../utils/manager/extensions/custom_string_extensions.dart';

class LoginRequestParams {
  final String username;
  final String token;

  const LoginRequestParams({
    required this.username,
    required this.token,
  });

  Map<String, dynamic> get toJson => {
    "email": username,
    if (token.isNullOrEmpty) "token": token,
  };
}
