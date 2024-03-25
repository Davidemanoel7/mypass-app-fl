import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardControl extends GetxController {
  
  var isAuthenticated = false.obs;
  var pageIndex = 1.obs;

  void setOnboard() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool('hasOnboard', true);
  }

  @override
  void onInit() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    bool? onboarded = sharedPrefs.getBool('hasOnboard');
    bool? logged = sharedPrefs.getBool('authenticated');

    if ( logged == null ) {
      debugPrint('Logged [NULL]: $logged');
      await sharedPrefs.setBool('authenticated', false);
      logged = false; 
    }

    if ( onboarded == null ) {
      debugPrint('Onboarded [NULL]: $onboarded');
      await sharedPrefs.setBool('hasOnboard', false);
      onboarded = false; 
    }

    if ( onboarded && !logged ) {
      Get.offAllNamed('/signIn');
    } else if( onboarded && logged ) {
      Get.offNamed('/home');
    }

    super.onInit();
  }
}