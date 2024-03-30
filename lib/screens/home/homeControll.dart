import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';

class HomeControll extends GetxController {
  
  var user = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var profile = ''.obs;
  var loadRequest = false.obs;

  @override
  void onInit() async {
    bool user = await getProfile();
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
          user(respBody['user']);
          userName(respBody['name']);
          email(respBody['email']);
          profile(respBody['profileImage']);
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