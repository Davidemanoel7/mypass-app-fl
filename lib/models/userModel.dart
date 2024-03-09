class User{
  final String name;
  final String user;
  final String email;
  final String? userType;

  User({
    required this.name,
    required this.user,
    required this.email,
    this.userType
  });

  factory User.fromJson( Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      user: json['user'] as String,
      email: json['email'] as String,
      userType: json['userType'] ?? 'common'
    );
  }
}