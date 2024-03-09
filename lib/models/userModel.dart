class User{
  final String name;
  final String user;
  final String email;
  final String password;
  final String? userType;

  User({
    required this.name,
    required this.user,
    required this.email,
    required this.password,
    this.userType
  });

  factory User.fromJson( Map<String, dynamic> json) {
    return switch ( json ) {
      {
        "message": String _,
        "createdUser": {
          "name": String name,
          "user": String user,
          "email": String email,
          "password": String password,
          "userType": String userType
        },
        "token": String _
      } => User(
        name: name,
        user: user,
        email: email,
        password: password,
        userType: userType
      ),

      _ => throw const FormatException('Failed to load json data')
    };
  }
}