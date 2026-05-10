class RefreshTokenRequestParams {
  final String refreshToken;

  RefreshTokenRequestParams({required this.refreshToken});

  Map<String, dynamic> get toJson => {"refreshToken": refreshToken};
}
