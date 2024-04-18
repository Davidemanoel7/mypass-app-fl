import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/home/homeControll.dart';
import 'package:mypass/utils/themes.dart';
import 'package:mypass/widgets/components/customShimmer.dart';
import 'package:mypass/widgets/components/passwordButton.dart';
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: const ClampingScrollPhysics(),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Minhas senhas',
                          style: MyPassFonts.style.kLabelMedium(context,
                            color: MyPassColors.greyDarker
                          ),
                        ),
                        TextButton(
                          onPressed: () async => await homeControll.fetchPasswords(),
                          style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory
                          ),
                          child: const Text(
                            'ver todas',
                            style: TextStyle(
                              color: MyPassColors.purpleLight,
                              fontSize: 12.0,
                              // fontWeight: FontWeight.w300
                            ),
                          )
                        )
                      ],
                    ),
                    SizedBox(
                      child: 
                        ListView.separated(
                          itemCount: 4,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) =>
                            Obx(() => homeControll.loadRequest.value
                            ? CustomShimmer(
                                height: 84,
                                width: MediaQuery.of(context).size.width,
                                borderRadius: 16
                              )
                            : PasswordButton(
                                title: homeControll.listPasswords[index].description
                              )
                          )),
                          separatorBuilder: (context, index) => const SizedBox( height: 8),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}