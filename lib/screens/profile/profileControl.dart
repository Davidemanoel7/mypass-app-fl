import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/services/checkJWT.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileControl extends GetxController {

  Future<bool> deleteAccount() async {
    try {
      
      return true;
    } catch (e) {
      debugPrint('e');
      return false;
    }
  }

  Future<bool> logOut () async {
    try {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool('authenticated', false);
      await sharedPrefs.setString('token', '');
      await sharedPrefs.setString('user', '');
      return true;
    } catch (e) {
      debugPrint('\nError: $e');
      return false; 
    }
  }
}