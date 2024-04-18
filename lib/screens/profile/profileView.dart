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
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Obx(() => 
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Image.network(
                          profileControl.user.value.getProfileImage(),
                          fit: BoxFit.cover,
                          width: 160.0,
                          height: 160.0,
                        ),
                        Positioned(
                          bottom: 16.0,
                          right: 16.0,
                          child: IconButton.filled(
                            onPressed: () async => await profileControl.uploadImage(),
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: MyPassColors.whiteF0,
                              size: 24,
                            ),
                            splashColor: MyPassColors.blueLight,
                          )
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      profileControl.user.value.getUser(),
                      style: MyPassFonts.style.kLabelMedium(context,
                        color: MyPassColors.purpleLight,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      profileControl.user.value.getEmail(),
                      style: MyPassFonts.style.kLabelMedium(context,
                        color: MyPassColors.greyBD,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  Divider(
                    color: MyPassColors.greyBD.withOpacity(0.3),
                    thickness: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          width: 1,
                          color: MyPassColors.greyDarker,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              profileControl.user.value.getName(),
                              style: MyPassFonts.style.kLabelSmall(context,
                                color: MyPassColors.greyDarker
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                Get.toNamed('/changeData', parameters: { "AppBarTitle": 'nome' });
                              },
                              icon: const Icon(
                                Icons.mode_edit,
                                size: 22,
                                color: MyPassColors.greyDarker,
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          width: 1,
                          color: MyPassColors.greyDarker,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '********',
                              style: MyPassFonts.style.kLabelSmall(context,
                                color: MyPassColors.greyDarker
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                debugPrint('Ir para tela de mudar tenha');
                              },
                              icon: const Icon(
                                Icons.mode_edit,
                                size: 22,
                                color: MyPassColors.greyDarker,
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton(
                      onPressed: () => Get.toNamed('/deleteAccount'),
                      style: const ButtonStyle(
                        splashFactory: NoSplash.splashFactory
                      ),
                      child: const Text(
                        'Encerrar conta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: MyPassColors.redAlert,
                          decoration: TextDecoration.underline,
                          decorationColor: MyPassColors.redAlert,
                          decorationThickness: 1,
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            bool logout = await profileControl.logOut();
                            // if ( logout ){
                            //   Get.offAllNamed('/signIn');
                            // }
                          },
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sair',
                                  style: TextStyle(
                                    color: MyPassColors.redAlert.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Icon(
                                    Icons.logout_rounded,
                                    color: MyPassColors.redAlert.withOpacity(0.9),
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
            )
          ),
        ),
      )
    );
  }
}