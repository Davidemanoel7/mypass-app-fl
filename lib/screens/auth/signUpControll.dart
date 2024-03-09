import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpControl extends GetxController{
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  var isUserValid = false.obs;

  var signUpLoad = false.obs;

  Future<dynamic> signUp( String name, String user, String email, String senha ) async {
    dynamic body = {
      'name': name,
      'user': user,
      'email': email,
      'password': senha
    };

    try {
      signUpLoad(true);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

      var resp = await fetchData(
        Requests.signUp,
        body: body
      );

      switch ( resp.statusCode ) {
        case 200:
          var user = User.fromJson( jsonDecode(resp.body) as Map<String, dynamic>);
          final jwt = JWT.decode( resp.body['token'] );
          await sharedPreferences.setString('token', resp.body['token']);
          signUpLoad(false);
          return {
            "created": true,
          };
        default:
          signUpLoad(false);
          return {
            "created": false,
            "message": resp.body['message']
          };
      }

    } catch (e) {
      debugPrint('$e');
      return false; 
    }
  }
}