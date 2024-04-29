import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/models/pass_model.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/services/fetchData.dart';

class PassDetailController extends GetxController {
  PassDetailController({
    required this.pass
  });

  RxBool isLoad = false.obs;
  RxBool changed = false.obs;

  HomeControll homeControl = Get.find<HomeControll>();

  Rx<Password> pass;

  @override
  void onInit() async {
    isLoad(true);
    
    pass( pass.value );
    isLoad(false);
    super.onInit();
  }

  Future<bool> changePass({ String? description, String? url, String? password }) async {
    Map<String, dynamic> body = {
      "description": description ?? pass.value.description,
      "url": url ?? pass.value.url,
      "password": password ?? pass.value.password
    };
    
    isLoad(true);
    dynamic resp = await fetchData(
      Requests.changePass,
      params: '?id=${pass.value.id}',
      body: body
    );
    isLoad(false);

    try {
      switch ( resp.statusCode ) {
        case 200:
          Password updatedPass = homeControl.listPasswords.firstWhere((p0) => p0.id == pass.value.id );
          updatedPass.setDescription( body['description'] );
          updatedPass.setUrl( body['url']);
          updatedPass.setPassword(body['password']);
          homeControl.update();
          debugPrint('refresh homeController');
          return true;
        default:
          debugPrint('Status code: ${resp.statusCode}');
          return false;
      } 
    } catch (e) {
      debugPrint('$e');
      return false; 
    }
  }

  Future<bool> deletePassword() async {
    isLoad(true);
    dynamic resp = await fetchData(
      Requests.deletePass,
      params: '?id=${pass.value.id}'
    );
    isLoad(false);

    try {
      switch ( resp.statusCode ) {
      case 200:
        debugPrint('Password deleted successfully');
        homeControl.listPasswords.removeWhere((element) => element.id == pass.value.id );
        homeControl.update();
        return true;
      default:
      debugPrint('Any status code diff 200');
        return false;
    }
    } catch (e) {
      debugPrint('$e'); 
      return false;
    }
  }
}