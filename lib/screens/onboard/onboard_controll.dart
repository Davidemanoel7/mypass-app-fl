import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardControl extends GetxController {
  
  var isAuthenticated = false.obs;
  var pageIndex = 1.obs;

  void setOnboard() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool('hasOnboard', true);
  }

  @override
  void onInit() async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    
    final bool? onboarded = sharedPrefs.getBool('hasOnboard');
    final bool? logged = sharedPrefs.getBool('authenticated');
    
    if ( onboarded == null ) {
      await sharedPrefs.setBool('hasOnboard', false);
    }

    if ( onboarded == true && !logged! ) {
      Get.offAllNamed('/signIn');
    } else if( onboarded == true && logged! ) {
      Get.offNamed('/home');
    }

    super.onInit();
  }
}