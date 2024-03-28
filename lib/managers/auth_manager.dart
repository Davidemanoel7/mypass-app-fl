import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/cache_manager.dart';

class AuthenticationManager extends GetxController with SharedPrefManager{
  final isLogged = false.obs;
  
  @override
  void onInit() {
    debugPrint('\t# Check login Status');
    checkLoginStatus();
    super.onInit();
  }
  
  void logout() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    await saveToken(token!);
  }

  void checkLoginStatus() async {
    bool isAuth = await checkJwt();
    if ( isAuth ) {
      isLogged.value = true;
    } else {
      isLogged.value = false;
    }
  }

  Future<bool> checkJwt() async {
    String? jwtKey = dotenv.env['JWT_KEY'];
    String? token = await getToken();
    try {
      if (token == null ) {
        return false;
      }

      final jwt = JWT.verify(token, SecretKey(jwtKey!));
      debugPrint('Paylodad: ${jwt.payload}');
      return true;
    } on JWTExpiredException {
      debugPrint('JWT Expired. Fetch data to refresh token...');
      return false;
    } on JWTException catch ( e ) {
      debugPrint(e.message);
      return false;
    }
  }
}