import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileControl extends GetxController {
  
  var user = ''.obs;
  var email = ''.obs;
  var name = ''.obs;

  var loadRequest = false.obs;


  @override
  void onInit() async {
    loadRequest(true);
    bool user = await getProfile();
    loadRequest(false);
    super.onInit();
  }

  Future<bool> getProfile() async {
    try {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');

      dynamic result = await fetchData(
        Requests.getUser,
        token: token!
      );

      var respBody = jsonDecode(result.body) as Map<String, dynamic>;
      // User usr = User.fromJson(respBody);
      // debugPrint(respBody['name']);

      switch ( result.statusCode ) {
        case 200:
          user(respBody['user']);
          name(respBody['name']);
          email(respBody['email']);
          return true;
        case 401:
          debugPrint('Auth failed or Unauthorized');
          return false;
        case 404:
          debugPrint('Not found');
          return false;
        default:
          debugPrint('Something wrong');
          return false;
      } 
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }

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