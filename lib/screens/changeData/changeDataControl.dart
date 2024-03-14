import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/profile/profileControl.dart';
import 'package:mypass/services/fetchData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeDataControl extends GetxController {
  var validValue = false.obs;

  var loadRequest = false.obs;

  Future<bool> changeData( String data ) async {
    ProfileControl profileControl = Get.find();
    loadRequest(true);
    try {
      final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
      String? token = sharedPrefs.getString('token');

      dynamic resp = await fetchData(
        Requests.updateUser,
        token: token!,
        body: {
          "name": data,
        }
      );

      var responseBody = jsonDecode(resp.body) as Map<String, dynamic>;

      switch ( resp.statusCode ) {
        case 200:
          profileControl.name(data);
          profileControl.update();
          // loadRequest(false);
          return true;
        default:
          return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false; 
    } finally {
      loadRequest(false);
      validValue(false);
    }
  }
}