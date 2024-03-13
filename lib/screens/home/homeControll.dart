import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeControll extends GetxController {
  
  var userName = ''.obs;
  var email = ''.obs;
  var userId = ''.obs;

  @override
  void onInit() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    final String? user = sharedPreferences.getString('user');
    userName(user);

    final String? mail = sharedPreferences.getString('email');
    email(mail);

    final String? userID = sharedPreferences.getString('userId');
    userId(userID);

    super.onInit();
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