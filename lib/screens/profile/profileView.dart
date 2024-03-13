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
                  initialValue: Get.arguments['user'],
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
                  initialValue: Get.parameters['email'],
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
                  initialValue: 'name',
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: (){},
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
                  initialValue: 'senha',
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
                    GestureDetector(
                      onTap: () => debugPrint('Encerrar conta'),
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Encerrar conta',
                          style: TextStyle(
                            color: MyPassColors.redAlert,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationThickness: 4,
                            decorationStyle: TextDecorationStyle.solid,
                            decorationColor: MyPassColors.redAlert,
                          ),
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