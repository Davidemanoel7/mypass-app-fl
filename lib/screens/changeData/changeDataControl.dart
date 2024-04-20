import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/screens/profile/profileControl.dart';
import 'package:mypass/services/fetchData.dart';

class ChangeDataControl extends GetxController {
  var validValue = false.obs;

  var loadRequest = false.obs;

  Future<bool> changeName( String data ) async {
    HomeControll homeControll = Get.find();
    ProfileControl profileControll = Get.find();
    loadRequest(true);

    try {
      dynamic resp = await fetchData(
        Requests.updateUser,
        body: {
          "name": data,
        }
      );

      // var responseBody = jsonDecode(resp.body) as Map<String, dynamic>;

      switch ( resp.statusCode ) {
        case 200:
          homeControll.usr.value.setName( data );
          homeControll.usr.refresh();
          profileControll.user.refresh();
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