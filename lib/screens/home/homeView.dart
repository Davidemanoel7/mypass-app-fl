import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInControll.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/utils/themes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeControll homeControll = Get.put(HomeControll());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24.0 ),
              child: Row(
                children: [
                  Text('Hi, '),
                  Icon( Icons.menu_rounded)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap:() {
                },  
                child: const Row(
                  children: [
                    Text('Nova senha'),
                    Icon(Icons.add)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                bool logout = await homeControll.logOut();
                debugPrint('$logout');
                if ( logout ) {
                  Get.back();
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: MyPassColors.redAlert,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}