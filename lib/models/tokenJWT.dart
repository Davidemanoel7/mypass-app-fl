class Auth {

  final String? token;
  final String message;

  Auth({
    required this.token,
    required this.message
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'token': String token!,
        'message': String message,
      } => Auth(
        token: token,
        message: message
      ),
      _ => throw const FormatException('Failed to load json data')
    };
  }
}