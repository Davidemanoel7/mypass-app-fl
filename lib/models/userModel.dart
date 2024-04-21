class User{
  String name;
  String user;
  String email;
  final String? userType;
  String? profileImage;

  User({
    required this.name,
    required this.user,
    required this.email,
    this.userType,
    this.profileImage
  });

  factory User.fromJson( Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      user: json['user'] as String,
      email: json['email'] as String,
      userType: json['userType'] ?? 'common',
      profileImage: json['profileImage'] ?? ''
    );
  }

  String getName () => name;
  void setName( String newName ) => name = newName;

  String getUser () => user;
  void setUser( String newUsr ) => user = newUsr;

  String getEmail () => email;
  void setEmail( String newEmail ) => email = newEmail;

  String getProfileImage () => profileImage ?? '';
  void setProfileImage( String newProfileImage ) => profileImage = newProfileImage;
}