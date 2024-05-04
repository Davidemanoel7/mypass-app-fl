import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/services/fetchData.dart';

class SavePassControll extends GetxController {
  RxString url = ''.obs;
  RxString description = ''.obs;
  RxBool loadRequest = false.obs;

  Future<bool> savePassword( String pass) async {
    try {
      dynamic body = {
        "url": url.value,
        "description": description.value,
        "password": pass
      };

      loadRequest(true);
      dynamic response = await fetchData(
        Requests.createPass,
        body: body
      );
      loadRequest(false);

      switch ( response.statusCode ) {
        case 201:
          Get.find<HomeControll>().update();
          return true;
        case 401:
          return false;
        case 404:
          return false;
        default:
          return false;
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}