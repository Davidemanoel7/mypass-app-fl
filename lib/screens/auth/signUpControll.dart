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
  var isNameValid = false.obs;

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
        case 201:
          var responseBody = jsonDecode(resp.body) as Map<String, dynamic>;
          debugPrint('${responseBody['createdUser']}');
          var user = User.fromJson( responseBody['createdUser'] as Map<String, dynamic>);
          final jwt = JWT.decode( responseBody['token']);
          await sharedPreferences.setString('token', responseBody['token']);
          signUpLoad(false);
          return {
            "created": true,
          };
        // case: 4
        default:
          var signUpResp = jsonDecode(resp.body) as Map<String, dynamic>;
          debugPrint('$signUpResp');
          // if (signUpResp['message'])
          signUpLoad(false);
          return {
            "created": false,
            "message": signUpResp['message']
          };
      }

    } catch (e) {
      signUpLoad(false);
      debugPrint('$e');
      return {
        "create": false,
        "message": 'Erro durante criação da conta... Tente outra vez.'
      }; 
    }
  }
}