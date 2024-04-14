import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/services/fetchData.dart';

class HomeControll extends GetxController {
  
  // var user = ''.obs;
  // var userName = ''.obs;
  // var email = ''.obs;
  // var profile = ''.obs;
  var loadRequest = false.obs;

  Rx<User> usr =  User(email: '', name: '', user: '').obs;

  @override
  void onInit() async {
    bool user = await getProfile();
    if ( user ) super.update();
    debugPrint('chegou carai');
    super.onInit();
  }

  Future<bool> getProfile() async {
    try {
      loadRequest(true);
      dynamic result = await fetchData(
        Requests.getUser,
      );
      loadRequest(false);

      var respBody = jsonDecode(result.body) as Map<String, dynamic>;

      switch ( result.statusCode ) {
        case 200:
          usr.value.setName(respBody['name']);
          usr.value.setUser(respBody['user']);
          usr.value.setEmail(respBody['email']);
          usr.value.setProfileImage(respBody['profileImage']);
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
}