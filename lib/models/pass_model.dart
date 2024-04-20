class Password {
  String id;
  String description;
  String password;
  String url;
  String modifiedAt;
  
  Password({
    required this.id,
    required this.description,
    required this.password,
    required this.url,
    required this.modifiedAt
  });

  factory Password.fromJson( Map<String, dynamic> json ) {
    return Password(
      id: json['id'],
      description: json['description'],
      password: json['password'],
      url: json['url'],
      modifiedAt: json['modifiedAt']
    );
  }

  String getDescription() => description;
  void setDescription( String newDescription ) => description = newDescription;

  String getPassword() => password;
  void setPassword( String newPass ) => password = newPass;

  String getUrl() => url;
  void setUrl( String newUrl ) => url = newUrl;
}