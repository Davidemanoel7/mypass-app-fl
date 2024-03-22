import 'dart:math';

import 'package:get/get.dart';

class CreatePassControl extends GetxController {
  RxBool numbers = false.obs;
  RxBool special = false.obs;
  RxBool uppercase = false.obs;

  RxDouble sliderValue = 6.0.obs;

  String generatePass(){
    double len = sliderValue.value;
    var pass = 'abcdefghijklmnopqrstuvwxyz';
    var newPass = '';

    pass += numbers.value ? '0123456789' : '';
    pass += special.value ? '!@#_*' : '';
    pass += uppercase.value ? pass.toUpperCase() : '';

    for (var i = 0; i < len; i++) {
      int rand = Random().nextInt(pass.length);
      newPass += pass[rand];
    }

    return newPass;
  }
}