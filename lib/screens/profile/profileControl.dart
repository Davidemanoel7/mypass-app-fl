import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileControl extends GetxController with SharedPrefManager {
  
  var user = ''.obs;
  var email = ''.obs;
  var userName = ''.obs;

  var loadRequest = false.obs;


  @override
  void onInit() async {
    loadRequest(true);
    HomeControll homeControllData = Get.find<HomeControll>();
    user(homeControllData.user.value);
    userName(homeControllData.userName.value);
    email(homeControllData.email.value);
    loadRequest(false);
    super.onInit();
  }

  Future<bool> logOut () async {
    try {
      final AuthenticationManager authManager = Get.find<AuthenticationManager>();
      await authManager.logout();
      return true;

    } catch (e) {
      debugPrint('\nError: $e');
      return false; 
    }
  }
}