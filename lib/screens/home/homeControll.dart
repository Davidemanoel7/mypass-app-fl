import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/models/pass_model.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/services/fetchData.dart';

class HomeControll extends GetxController {
  
  RxBool loadRequest = false.obs;

  Rx<User> usr =  User(email: '', name: '', user: '').obs;
  RxList<Password> listPasswords = <Password>[].obs;

  @override
  void onInit() async {
    loadRequest(true);

    bool user = await getProfile();
    await fetchPasswords();
    if ( user ) super.update();

    loadRequest(false);
    super.onInit();
  }

  Future<bool> getProfile() async {
    try {
      dynamic result = await fetchData(
        Requests.getUser,
      );

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

  Future<void> fetchPasswords() async {
    dynamic resp = await fetchData(
      Requests.getAllPass
    );
    try {
      Map<String, dynamic> responseBody = jsonDecode(resp.body);

      switch ( resp.statusCode ){
        case 200:
          debugPrint('Status Code 200');

          listPasswords( List<dynamic>.from(responseBody['passwords'])
            .map((p) => Password.fromJson(p)).toList()
          );
          return;
        case 401:
          debugPrint('Status Code 401');
          return;
        case 404:
          debugPrint('Status Code 404');
          return;
        case 500:
          debugPrint('Status Code 500');
        default:
          return;
      }  
    } catch (e) {
      debugPrint('$e'); 
    }
  }
}