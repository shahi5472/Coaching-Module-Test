import 'package:equatable/equatable.dart';

import '../../../../base/services/data/user/user_model.dart';

class LoginResponseModel extends Equatable {
  final bool success;
  final String message;
  final LoginData data;
  final String error;

  const LoginResponseModel({
    this.success = false,
    this.message = "",
    this.data = const LoginData(),
    this.error = "",
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      data: json['data'] != null ? LoginData.fromJson(json['data']) : LoginData.empty(),
      error: json['error'] ?? "",
    );
  }

  factory LoginResponseModel.empty() => const LoginResponseModel();

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
      'error': error,
    };
  }

  @override
  List<Object?> get props => [
    success,
    message,
    data,
    error,
  ];
}

class LoginData extends Equatable {
  final String token;
  final String tokenType;
  final int expiresIn;
  final UserModel user;

  const LoginData({
    this.token = "",
    this.tokenType = "",
    this.expiresIn = 0,
    this.user = const UserModel(),
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] ?? '',
      tokenType: json['token_type'] ?? '',
      expiresIn: json['expires_in'] ?? 0,
      user: json['user'] == null ? UserModel.empty() : UserModel.fromJson(json['user']),
    );
  }

  factory LoginData.empty() {
    return LoginData(
      token: '',
      tokenType: '',
      expiresIn: 0,
      user: UserModel.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user.toJson(),
    };
  }

  @override
  List<Object?> get props => [
    token,
    tokenType,
    expiresIn,
    user,
  ];
}
