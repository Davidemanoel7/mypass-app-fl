import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/utils/themes.dart';
import 'package:mypass/widgets/components/customShimmer.dart';
import 'package:shimmer/shimmer.dart';

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
          title: Obx(() => homeControll.loadRequest.value
            ? const CustomShimmer(
                height: 8,
                width: 128, 
                borderRadius: 8
              )
            : Text(
                'Olá, ${homeControll.usr.value.user}',
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
              child:
                Obx(() =>
                  homeControll.loadRequest.value
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: Shimmer.fromColors(
                        baseColor: MyPassColors.greyBD,
                        highlightColor: MyPassColors.whiteF0,
                        child: const Icon(
                          Icons.menu
                        ),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Get.toNamed('/profile');
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: MyPassColors.purpleLight,
                      )
                    ),
                )
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
                child: Obx(() =>
                  GestureDetector(
                    onTap:() => homeControll.loadRequest.value ? null : Get.toNamed('/create/password'),
                    child: homeControll.loadRequest.value
                    ? CustomShimmer(
                      height: 92,
                      width: MediaQuery.of(context).size.width,
                      borderRadius: 24.0
                    )
                    : Container(
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
                )
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