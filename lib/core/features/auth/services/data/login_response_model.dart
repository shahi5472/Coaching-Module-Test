import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final String type;
  final String token;

  const LoginResponseModel({
    this.type = "",
    this.token = "",
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      type: json['type'] ?? "",
      token: json['token'] ?? "",
    );
  }

  factory LoginResponseModel.empty() => const LoginResponseModel();

  Map<String, dynamic> toJson() => {'type': type, 'token': token};

  @override
  List<Object?> get props => [type, token];
}
