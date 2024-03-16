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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(() => 
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
                          color: MyPassColors.greyBD,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          profileControl.user.value,
                          style: MyPassFonts.style.kLabelSmall(context,
                            color: MyPassColors.greyBD
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                Obx(() => 
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
                          color: MyPassColors.greyBD,
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          profileControl.email.value,
                          style: MyPassFonts.style.kLabelSmall(context,
                            color: MyPassColors.greyBD
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                Obx(() => 
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
                              profileControl.name.value,
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
        ),
      )
    );
  }
}