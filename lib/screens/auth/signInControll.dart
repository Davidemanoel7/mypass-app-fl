import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/models/tokenJWT.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInControl extends GetxController with SharedPrefManager {
  
  var isAuth = false.obs;
  var isEmailValid = false.obs;
  var isPassValid = false.obs;
  // var token = ''.obs;

  // var email = ''.obs;
  // var user = ''.obs;
  // var userId = ''.obs;
  // var userType = ''.obs;

  var authLoad = false.obs;

  Future<dynamic> logIn( String email, String senha) async {
    try {
      // final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

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

          final acessJwt = JWT.decode(auth.acessToken!);

          await setItemFromCache('acessToken', TypeKey.String, auth.acessToken );
          await setItemFromCache('refreshToken', TypeKey.String, auth.refreshToken );

          await setItemFromCache('isAuth', TypeKey.bool, true );

          await setItemFromCache('userIdKey', TypeKey.String, acessJwt.payload['userId']);

          var userID = await getItemFromCache('userIdKey', TypeKey.String);
          debugPrint('$userID');

          dynamic response = {
            'auth': true,
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