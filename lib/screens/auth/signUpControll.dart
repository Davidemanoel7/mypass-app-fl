import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpControl extends GetxController{
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  var isUserValid = false.obs;
  var isNameValid = false.obs;

  var signUpLoad = false.obs;

  AuthenticationManager authenticationManager = Get.put(AuthenticationManager());

  Future<dynamic> signUp( String name, String user, String email, String senha ) async {
    dynamic body = {
      'name': name,
      'user': user,
      'email': email,
      'password': senha
    };

    try {
      signUpLoad(true);
      var resp = await fetchData(
        Requests.signUp,
        body: body
      );
      signUpLoad(false);

      switch ( resp.statusCode ) {
        case 201:
          var responseBody = jsonDecode(resp.body) as Map<String, dynamic>;
          User.fromJson( responseBody['createdUser'] as Map<String, dynamic>);
          await authenticationManager.saveToken('acessToken', responseBody['acessToken']);
          await authenticationManager.saveToken('refreshToken', responseBody['refreshToken']);
          
          return {
            "created": true,
          };

        case 409:
          return {
            "created": false,
            "message": 'Este email já foi usado por outro usuário. Tente outro!'
          };

        default:
          return {
            "created": false,
            "message": 'Não foi possível criar a conta. Tente novamente...'
          };
      }

    } catch (e) {
      debugPrint('$e');
      return {
        "create": false,
        "message": 'Erro durante criação da conta... Tente outra vez.'
      }; 
    }
  }
}