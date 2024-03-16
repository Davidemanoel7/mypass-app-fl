import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/profile/profileControl.dart';
import 'package:mypass/services/fetchData.dart';

class ChangeDataControl extends GetxController {
  var validValue = false.obs;

  var loadRequest = false.obs;

  Future<bool> changeName( String data ) async {
    ProfileControl profileControl = Get.find();
    loadRequest(true);

    try {
      dynamic resp = await fetchData(
        Requests.updateUser,
        body: {
          "name": data,
        }
      );

      var responseBody = jsonDecode(resp.body) as Map<String, dynamic>;

      switch ( resp.statusCode ) {
        case 200:
          profileControl.name(data);
          profileControl.update();
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