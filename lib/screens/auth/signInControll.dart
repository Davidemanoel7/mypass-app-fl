import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SignInControl extends GetxController{
  
  var isAuth = false.obs;
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  var token = ''.obs;

  var email = ''.obs;
  var user = ''.obs;
  var userId = ''.obs;
  var userType = ''.obs;


  Future<bool> logIn( String email, String senha) async {
    try {
      final dynamic body = { 'email': email, 'password': senha };
      var resp = await fetchData(
        Requests.signIn,
        body: body
      );

      if ( resp.statusCode == 200 ) {
        var auth = Auth.fromJson( jsonDecode(resp.body) as Map<String, dynamic>);

        final jwt = JWT.decode(auth.token);

        this.email = RxString(email);

        userId = RxString(jwt.payload['userId']);
        debugPrint('$userId');

        user = RxString(jwt.payload['user']);
        debugPrint('$user');

        userType = RxString(jwt.payload['userType']);
        debugPrint('$userType');

        token = RxString(auth.token);
        // debugPrint(auth.token); //store this token

        isAuth(true);
        return true;
      } else {
        return false;
      // throw Exception('Failed to make request...');
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

  void logOut () {
    isAuth(false);
    token = RxString('');
    Future.delayed( const Duration(milliseconds: 200));
    Get.toNamed('/signIn');
  }
}

class Auth {

  final String token;
  final String message;

  Auth({
    required this.token,
    required this.message
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'token': String token,
        'message': String message,
      } => Auth(
        token: token,
        message: message
      ),
      _ => throw const FormatException('Failed to load json data')
    };
  }
}