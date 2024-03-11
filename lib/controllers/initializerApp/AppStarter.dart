
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypass/utils/themes.dart';

import '../../routers/routes.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppStarter extends StatelessWidget {
  const AppStarter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        fontFamily: 'Nunito',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.light(),
        appBarTheme: const AppBarTheme(
          color: MyPassColors.purpleLight,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MyPassColors.whiteF0,
            statusBarIconBrightness: Brightness.dark
          ),
        ),
      ),
      scrollBehavior: const MaterialScrollBehavior(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/onboard',
      getPages: appRoutes(),
    );
  }
}