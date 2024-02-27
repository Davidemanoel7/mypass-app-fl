import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';

class SignInControl extends GetxController{
  
  var isAuth = false.obs;
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  var token = ''.obs;

  Future<bool> logIn( String user, String senha) async {
    
    final dynamic body = { 'user': user, 'password': senha };
    
    var resp = await fetchData(
      Requests.signIn,
      body: body
    );

    if ( resp.statusCode == 200 ) {
      var auth = Auth.fromJson( jsonDecode(resp.body) as Map<String, dynamic>);
      token = RxString(auth.token);
      debugPrint(auth.token); //store this token
      
      isAuth(true);
      return true;
      
    } else {
      return false;
      // throw Exception('Failed to make request...');
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