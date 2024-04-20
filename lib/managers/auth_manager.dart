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
  void onInit() async {
    await checkLoginStatus();
    super.onInit();
  }

  Future<bool> login( String acessToken, String refreshToken) async {
    await setItemFromCache('acessToken', TypeKey.String, acessToken );
    await setItemFromCache('refreshToken', TypeKey.String, refreshToken );
    await setItemFromCache('isAuth', TypeKey.bool, true );
    isLogged(true);
    return true;
  }
  
  Future<void> logout() async {
    isLogged.value = false;
    await removeToken('acessToken');
    await removeToken('refreshToken');
    await setItemFromCache('isAuth', TypeKey.bool, false );
    debugPrint('Logout Successfully');

    Get.offAllNamed('/signIn');
  }

  Future<void> checkLoginStatus() async {
    isLogged( await checkJwt() );
  }

  Future<bool> checkJwt() async {
    String? acessToken = await getToken('acessToken');
    String? refreshToken = await getToken('refreshToken');
    
    try {
      if ( acessToken == null || refreshToken == null ) {
        debugPrint('\nAcessToken: $acessToken\nRefreshToken: $refreshToken\n');
        return false;
      }

      bool acessTokenIsValid = await verifyToken( acessToken );

      bool refreshTokenIsValid = await verifyToken( refreshToken );

      if ( !acessTokenIsValid   & refreshTokenIsValid ) {
        // debugPrint('AcessToken invalid. generateNewAcessToken called.');
        String newToken = await generateNewAcessToken( refreshToken );
        // debugPrint(newToken);
        await saveToken( 'acessToken', newToken );
        return true;
      } else if ( !refreshTokenIsValid ) {
        // debugPrint('refresh invalid... Logout now');
        await logout();
        return false;
      } else {
        return true;
      }
    } catch ( e ) {
      debugPrint('$e');
      return false;
    }
  }

  Future<bool> verifyToken( String token ) async {
    String? jwtKey = dotenv.env['JWT_KEY'];
    try {
      JWT.verify(token, SecretKey(jwtKey!));
      return true;
    } on JWTExpiredException {
      return false;
    } on JWTInvalidException catch ( e ) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<dynamic> generateNewAcessToken( String refreshToken) async {
    try {
      dynamic resp = await fetchData(
        Requests.getAcessToken,
        body: {
          'refreshToken': refreshToken
        }
      );

      switch ( resp.statusCode ) {
        case 200:
          Map<String, dynamic> respBody = jsonDecode(resp.body);
          debugPrint(respBody['acessToken']);
          await saveToken('acessToken', respBody['acessToken']);
          return respBody['acessToken'] as String;
        default:
          return null;
      }
    } catch ( error ) {
      debugPrint('$error');
      return null;
    }
  }
}