import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/models/tokenJWT.dart';
import 'package:mypass/services/fetchData.dart';
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

      switch ( resp.statusCode ) {
        case 200:
          var auth = Auth.fromJson( jsonDecode(resp.body) as Map<String, dynamic>);
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

          dynamic response = {
            "auth": true,
            "token": auth.token!,
            "message": auth.message
          };
          debugPrint('$response');
          return response;

        default:
          var loginResp = jsonDecode(resp.body) as Map<String, dynamic>;
          dynamic response = {
            'auth': false,
            'message': loginResp['message']
          };
          authLoad(false);
          return response;
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