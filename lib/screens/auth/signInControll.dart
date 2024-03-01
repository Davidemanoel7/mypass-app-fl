import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInControl extends GetxController{
  
  var isAuth = false.obs;
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  var token = ''.obs;

  var email = ''.obs;
  var user = ''.obs;
  var userId = ''.obs;
  var userType = ''.obs;

  var authLoad = false.obs;

  Future<dynamic> logIn( String email, String senha) async {
    try {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

      authLoad(true);
      final dynamic body = { 'email': email, 'password': senha };
      var resp = await fetchData(
        Requests.signIn,
        body: body
      );
      var auth = Auth.fromJson( jsonDecode(resp.body) as Map<String, dynamic>);

      switch ( resp.statusCode) {
        case 200:
          final jwt = JWT.decode(auth.token!);
          this.email = RxString(email);

          // store userId on cache
          userId = RxString(jwt.payload['userId']);
          await sharedPrefs.setString('userId', jwt.payload['userId']);

          user = RxString(jwt.payload['user']);

          userType = RxString(jwt.payload['userType']);

          // store token on cache
          token = RxString(jwt.toString());
          await sharedPrefs.setString( 'token', auth.token! );

          // store auth on cache
          isAuth( await sharedPrefs.setBool('authenticated', true) );
          authLoad(false);
          
          return {
            "auth": true,
            "token": auth.token!,
            "message": auth.message
          };
        default:
          return {
            "auth": false,
            "message": auth.message
          };
      }
    } catch (e) {
      debugPrint('\nError: $e');
      return false; 
    }
  }

  Future<bool> signUp() async {
    // const response = http.get()
    return true;
  }
}

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