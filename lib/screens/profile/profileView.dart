import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/profile/profileControl.dart';
import 'package:mypass/utils/themes.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileControl profileControl = Get.put(ProfileControl());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,  
          elevation: 0,
          title: Text(
            'Perfil',
            style: MyPassFonts.style.kLabelMedium(context,
              color: MyPassColors.black1B,
              fontWeight: FontWeight.w700
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  enabled: false,
                  readOnly: true,
                  initialValue: Get.arguments['user'] ?? 'Name',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyPassColors.greyBD,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  enabled: false,
                  readOnly: true,
                  initialValue: Get.arguments['email'] ?? 'email',
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyPassColors.greyBD,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  readOnly: true,
                  initialValue: Get.arguments['name'] ??'Nome do usuário',
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        Get.toNamed('/changeData', parameters: { "AppBarTitle": 'nome' });
                      },
                      icon: const Icon(
                        Icons.mode_edit,
                        size: 22,
                        color: MyPassColors.greyDarker,
                      )
                    ),
                    hintStyle: MyPassFonts.style.kLabelSmall(context, color: const Color.fromARGB(73, 0, 0, 0)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyPassColors.greyBD,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  readOnly: true,
                  initialValue: '12345678',
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.mode_edit,
                        size: 22,
                        color: MyPassColors.greyDarker
                      )
                    ),
                    hintStyle: MyPassFonts.style.kLabelSmall(context, color: const Color.fromARGB(73, 0, 0, 0)),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: MyPassColors.greyBD,
                        strokeAlign: BorderSide.strokeAlignCenter,
                      ),
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: OutlinedButton(
                  onPressed: () => Get.toNamed('/deleteAccount'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: MyPassColors.redAlert,
                    ),
                    backgroundColor: Colors.white,
                    fixedSize: Size(
                      MediaQuery.of(context).size.width,
                      56.0,
                    ),
                    shape: LinearBorder.bottom(
                      size: 0.4,
                      alignment: BorderSide.strokeAlignCenter,
                    )
                  ),
                  child: Text(
                    'Encerrar conta',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.redAlert
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        bool logout = await profileControl.logOut();
                        if ( logout ){
                          Get.offAllNamed('/signIn');
                        }
                      },
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sair',
                              style: TextStyle(
                                color: MyPassColors.greyDarker,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Icon(
                                Icons.logout_rounded,
                                color: MyPassColors.greyDarker,
                                size: 22,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'v1.0.0',
                      style: MyPassFonts.style.kLabelSmall(context,
                        color: MyPassColors.greyBD 
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }
}