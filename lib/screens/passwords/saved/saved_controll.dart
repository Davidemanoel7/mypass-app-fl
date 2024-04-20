import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/models/pass_model.dart';
import 'package:mypass/services/fetchData.dart';

class SavedController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<Password> passwords = <Password>[].obs;
  RxInt pageNum = 1.obs;
  RxString errorMessage = ''.obs;


  @override
  void onInit() async {
    isLoading(true);
    await fetchPasswords();
    isLoading(false);
    super.onInit();
  }
  
  Future<void> fetchPasswords() async {
    dynamic resp = await fetchData(
      Requests.getAllPass,
      params: '?page=$pageNum'
    );

    try {
      Map<String, dynamic> respBody = jsonDecode( resp.body );

      switch ( resp.statusCode ) {
        case 200:
          List<Password> pass = List<dynamic>.from( respBody['passwords'])
                              .map( (p) => Password.fromJson(p)).toList();
          if ( pass.isNotEmpty ) {
            passwords.addAll( pass );
          } else {
            debugPrint('pass\'s empty');
          }
          debugPrint('Status code 200');
          return;
        default:
          errorMessage('Algo de errado ocorreu');
          return;
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}