import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mypass/services/fetchData.dart';

class ForgotControll extends GetxController{

  var emailValid = false.obs;
  var forgotLoad = false.obs;

  Future<dynamic> forgot( String email ) async {
  
    dynamic body = {
      "email": email
    };

    try {
      forgotLoad(true);
      var resp = await fetchData(
        Requests.forgotPass,
        body: body
      );

      Map<String, dynamic> responseBody = jsonDecode(resp.body);

      switch ( resp.statusCode ) {
        case 200:
          forgotLoad(false);
          return {
            "sended": true,
            "message": responseBody['message']
          };
        case 404:
          forgotLoad(false);
          return {
            "sended": false,
            "message": responseBody['message']
          };
        case 500:
          forgotLoad(false);
          return {
            "sended": false,
            "message": responseBody['message']
          };
        default:
          forgotLoad(false);
          ErrorDescription('Algo deu errado... Tente novamente mais tarde.');
      }
    } catch (e) {
      debugPrint('$e');
      forgotLoad(false);
      return {
        "sended": false,
        "message": 'Algo deu errado... Tente novamente mais tarde.'
      };
    }
  }
}