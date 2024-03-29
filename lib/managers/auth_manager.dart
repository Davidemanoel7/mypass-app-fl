import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/services/fetchData.dart';

class AuthenticationManager extends GetxController with SharedPrefManager{
  final isLogged = false.obs;
  
  @override
  void onInit() {
    debugPrint('\t# Check login Status');
    checkLoginStatus();
    super.onInit();
  }
  
  Future<void> logout() async {
    isLogged.value = false;
    await removeToken('acessToken');
    await removeToken('refreshtoken');
  }

  void login(String token, value) async {
    isLogged.value = true;
    await saveToken(token, value);
  }

  Future<void> checkLoginStatus() async {
    bool isAuth = await checkJwt();
    if ( isAuth ) {
      isLogged.value = true;
    } else {
      isLogged.value = false;
    }
  }

  Future<bool> checkJwt() async {
    String? jwtKey = dotenv.env['JWT_KEY'];
    String? acessToken = await getToken('acessToken');
    String? refreshToken = await getToken('refreshToken');
    
    try {
      if ( acessToken == null ) {
        return false;
      }

      final jwt = JWT.verify( acessToken, SecretKey(jwtKey!) );
      return true;

    } on JWTExpiredException {
      if ( refreshToken != null ) {
        debugPrint('Acess token expired. Try signIn using Refresh Token...');
        String newToken = await generateNewAcessToken( refreshToken );

        if ( newToken.isNotEmpty ) {
          await saveToken('acessToken', newToken );
          return true;
        }
      }
      return false;
    } on JWTException catch ( e ) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<String> generateNewAcessToken( String refreshToken) async {
    
    try {
      dynamic resp = await fetchData(
        Requests.getAcessToken,
        body: {
          refreshToken: refreshToken
        }
      );
      debugPrint('${resp.body}');

      switch ( resp.statusCode ) {
        case 200:
          var newAcessToken = jsonDecode(resp.body['acessToken']);
          return newAcessToken as String;
        case 401:
          return '';
        default:
          return '';
      }       
    } catch (e) {
      debugPrint('$e');
      return '';
    }
  }
}