import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/models/tokenJWT.dart';
import 'package:mypass/services/fetchData.dart';

class SignInControl extends GetxController with SharedPrefManager {

  AuthenticationManager authManager = Get.find<AuthenticationManager>();
  
  var isAuth = false.obs;
  var isEmailValid = false.obs;
  var isPassValid = false.obs;

  var authLoad = false.obs;

  Future<dynamic> logIn( String email, String senha) async {
    try {
      authLoad(true);
      final dynamic body = { 'email': email, 'password': senha };
      var resp = await fetchData(
        Requests.signIn,
        body: body
      );
      authLoad(false);

      var respbody = jsonDecode(resp.body) as Map<String, dynamic>;

      switch ( resp.statusCode ) {
        case 200:
          var auth = Auth.fromJson( respbody );

          bool logged = await authManager.login( auth.acessToken!, auth.refreshToken! );

          dynamic response = {
            'auth': logged,
          };
          return response;

        case 401:
          dynamic response = {
            'auth': false,
            'message': 'Senha incorreta'
          };
          return response;

        case 404:
          dynamic response = {
            'auth': false,
            'message': 'Nenhum usuário encontrado com este email.'
          };
          return response;

        default:
          dynamic response = {
            'auth': false,
            'message': 'Oops. talvez estejamos com instabilidade no servidor. Tente novamentte mais tarde'
          };
          return response;
      }
    } catch (e) {
      debugPrint('\nError: $e');
      return false; 
    }
  }
}