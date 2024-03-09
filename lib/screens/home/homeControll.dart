import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeControll extends GetxController {
  

  Future<bool> logOut () async {
    try {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool('authenticated', false);
      await sharedPrefs.setString('token', '');
      return true;
    } catch (e) {
      debugPrint('\nError: $e');
      return false; 
    }
  }
}