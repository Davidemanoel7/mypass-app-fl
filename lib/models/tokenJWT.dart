class Auth {

  final String? acessToken;
  final String? refreshToken;

  Auth({
    required this.acessToken,
    required this.refreshToken,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'acessToken': String acessToken,
        'refreshToken': String refreshToken,
      } => Auth(
        acessToken: acessToken,
        refreshToken: refreshToken
      ),
      _ => throw const FormatException('Failed to load json data')
    };
  }
}