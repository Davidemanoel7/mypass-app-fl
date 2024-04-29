import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/models/pass_model.dart';
import 'package:mypass/models/userModel.dart';
import 'package:mypass/services/fetchData.dart';

class HomeControll extends GetxController {
  
  RxBool loadRequest = false.obs;

  Rx<User> usr = User(email:'', name: '', user: '', profileImage: '', userType: '').obs;
  RxList<Password> listPasswords = <Password>[].obs;
  RxInt pageNum = 1.obs;

  @override
  void onInit() async {
    loadRequest(true);
    await getProfile();
    await fetchPasswords();
    loadRequest(false);
    super.onInit();
  }

  @override
  void refresh() {
    usr.refresh();
    listPasswords.refresh();
    super.refresh();
  }

  Future<void> getProfile() async {
    try {
      dynamic result = await fetchData(
        Requests.getUser,
      );

      var respBody = jsonDecode(result.body) as Map<String, dynamic>;

      switch ( result.statusCode ) {
        case 200:
          usr(User.fromJson( respBody ));
          return;
        case 401:
          debugPrint('Auth failed or Unauthorized');
          return;
        case 404:
          debugPrint('Not found');
          return;
        default:
          debugPrint('Something wrong');
          return;
      } 
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchPasswords() async {
    dynamic resp = await fetchData(
      Requests.getAllPass,
      params: '?page=$pageNum'
    );
    try {
      Map<String, dynamic> responseBody = jsonDecode(resp.body);

      switch ( resp.statusCode ){
        case 200:
          List<Password> responseBodyPass = List<Map<String, dynamic>>.from(responseBody['passwords'])
            .map((p) => Password.fromJson(p)).toList();
          
          if ( responseBodyPass.isNotEmpty ) {
            debugPrint('${responseBody['currentPage']}/${responseBody['totalPages']}');
            listPasswords.addAll( responseBodyPass );
            update();
          } else {
            debugPrint('Pass empty. Page $pageNum/${responseBody['totalPages']}');
          }
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