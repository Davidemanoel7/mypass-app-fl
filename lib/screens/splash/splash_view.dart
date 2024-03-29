import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/auth_manager.dart';
import 'package:mypass/screens/onboard/onboard_view.dart';
import 'package:mypass/utils/themes.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final AuthenticationManager _authManager = Get.put(AuthenticationManager());

  Future<void> initializeSettings() async {
    await _authManager.checkLoginStatus();

    bool? onboarded = await _authManager.getOnboard();
    bool? logged = _authManager.isLogged.value;


    onboarded ??= false;

    if ( onboarded && !logged ) {
      Get.offAllNamed('/signIn');
    } else if( onboarded && logged ) {
      Get.offNamed('/home');
    }
  }

  @override
  Widget build( BuildContext context) {
    return FutureBuilder(
      future: initializeSettings(),
      builder: (context, snapshot) {
        if ( snapshot.connectionState == ConnectionState.waiting ) {
          return waitingView();
        } else {
          if ( snapshot.hasError) {
            return errorView(context);
          }
          else {
            return OnboardView();
          }
        }
      },
    );
  }

  Scaffold waitingView() {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CircularProgressIndicator(
                color: MyPassColors.blueLight,
              ),
            ),
            Text('Carregando...')
          ],
        ),
      ),
    );
  }

  Scaffold errorView( BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Error on load screen...',
          style: MyPassFonts.style.kLabelMedium( context,
            color: MyPassColors.redAlert
          ),
        ),
      ),
    );
  }


}