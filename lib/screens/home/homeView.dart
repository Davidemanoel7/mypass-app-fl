import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/utils/themes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeControll homeControll = Get.put(HomeControll());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Obx(() => 
            Text(
              'Olá, ${homeControll.user.value}',
              style: MyPassFonts.style.kLabelMedium(context,
                color: MyPassColors.black1B,
                fontWeight: FontWeight.w700
              ),
            )
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: IconButton(
                onPressed: () {
                  Get.toNamed('/profile');
                },
                icon: const Icon(
                  Icons.menu,
                  color: MyPassColors.purpleLight,
                )
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(24.0),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap:() => debugPrint('Criar senha'),
                  child: Container(
                    height: 92,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: MyPassColors.whiteF0.withOpacity(0.2)
                      ),
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [
                          MyPassColors.purpleLight,
                          Color.fromARGB(255, 207, 20, 125),
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Nova senha',
                            style: MyPassFonts.style.kTitleMedium(context,
                              color: MyPassColors.whiteF0,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.add_circle_outline,
                          color: MyPassColors.whiteF0,
                          size: 32,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap:() => debugPrint('Minhas senhas'),
                  child: Container(
                    height: 91,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: MyPassColors.whiteF0.withOpacity(0.2)
                      ),
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        colors: [
                          MyPassColors.blueLight,
                          MyPassColors.purpleLight
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd
                      )
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Minhas senhas',
                            style: MyPassFonts.style.kTitleMedium(context,
                              color: MyPassColors.whiteF0,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.password_rounded,
                          color: MyPassColors.whiteF0,
                          size: 32,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'v1.0.0',
                      style: MyPassFonts.style.kLabelSmall(context,
                        color: MyPassColors.greyBD 
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}