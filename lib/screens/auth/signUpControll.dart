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
          var user = User.fromJson( responseBody['createdUser'] as Map<String, dynamic>);
          final jwt = JWT.decode( responseBody['token']);
          await sharedPreferences.setString('token', responseBody['token']);
          
          signUpLoad(false);
          return {
            "created": true,
          };

        case 409:
          signUpLoad(false);
          return {
            "created": false,
            "message": 'Este email já foi usado por outro usuário. Tente outro!'
          };

        default:
          var signUpResp = jsonDecode(resp.body) as Map<String, dynamic>;
          signUpLoad(false);
          return {
            "created": false,
            "message": 'Não foi possível criar a conta. Tente novamente...'
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