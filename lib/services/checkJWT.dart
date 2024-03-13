import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkJWT () async {
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String? jwtKey = dotenv.env['JWT_KEY'];
  
  final String? token = sharedPrefs.getString('token');
    try {
      final jwt = JWT.verify(token!, SecretKey(jwtKey!));
      debugPrint('Paylodad: ${jwt.payload}');
      return true;
    } on JWTExpiredException {
      debugPrint('JWT Expired');
      return false;
    } on JWTException catch ( e ) {
      debugPrint(e.message);
      return false;
    }
}