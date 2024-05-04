import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/managers/cache_manager.dart';
import 'package:mypass/utils/themes.dart';


class OnboardView extends StatelessWidget with SharedPrefManager {
  OnboardView({super.key});

  PageController pageControll = PageController( initialPage: 0 );

  @override
  Widget build(BuildContext context) {
    RxInt currentPage = 0.obs;  
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: pageControll,
      onPageChanged: (int index) async {
        debugPrint('index: $index');
        currentPage( index );
      },
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Image(
                image: AssetImage('./lib/assets/images/selected.png'),
                height: 120,
                fit: BoxFit.fitHeight,
              ),
              const Padding(
                padding: EdgeInsets.only( top: 64, bottom: 12 ),
                child: Text(
                  'Selecione as propriedades da senha a ser gerada...',
                  style: TextStyle(
                    color: MyPassColors.black1B,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12, bottom: 48 ),
                child: Text(
                  '...ou digite-a você mesmo',
                  style: TextStyle(
                    color: MyPassColors.black1B,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await setOnboard();
                      Get.offAllNamed('/signIn');
                    },
                    child: const Text(
                      'Pular',
                      style: TextStyle(
                        color: MyPassColors.greyBD,
                        fontSize: 14,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  // ProgressIndicator( currentPage: 1 ),
                  IconButton(
                    onPressed: () {
                      pageControll.nextPage(
                        duration: const Duration( milliseconds: 100),
                        curve: Curves.linear
                      );
                    },
                    icon: const Icon(
                      Icons.navigate_next_rounded,
                      color: MyPassColors.blueLight,
                      size: 32,
                    )
                  ),
                ],
              )
            ],
          ) 
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 24),
                child: Text(
                  'Gere uma senha aleatória e então salve ela no seu banco de senhas.',
                  style: TextStyle(
                    color: MyPassColors.greyDarker,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none
                  ),
                )
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 24 ),
                child: Image(
                  image: AssetImage('./lib/assets/images/random.png'),
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 48),
                child: Text(
                  '...suas senhas serão guardadas criptografadas',
                  style: TextStyle(
                    color: MyPassColors.greyDarker,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  // ProgressIndicator( currentPage: 2 ),
                  IconButton(
                    onPressed: () {
                      pageControll.nextPage(
                        duration: const Duration( milliseconds: 100),
                        curve: Curves.linear
                      );
                    },
                    icon: const Icon(
                      Icons.navigate_next_rounded,
                      color: MyPassColors.blueLight,
                      size: 32,
                    )
                  ),
                ],
              )
            ]
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 48 ),
                child: Image(
                  image: AssetImage('./lib/assets/images/shield_colored.png'),
                  height: 120,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 24),
                child: Text(
                  'Proteja seu banco de senha com autenticação...',
                  style: TextStyle(
                    color: MyPassColors.greyDarker,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none
                  ),
                ), 
              ),
              
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 24),
                child: Text(
                  'Somente você terá acesso!',
                  style: TextStyle(
                    color: MyPassColors.greyDarker,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decoration: TextDecoration.none
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await setOnboard();
                      Get.offAllNamed('/signIn');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: MyPassColors.purpleLight,
                        fontSize: 14,
                        decoration: TextDecoration.none
                      )
                    ),
                  )
                ],
              )
            ]
          ),
        )
      ]
    );
  }
}

List<Widget> pages = [
  
];

/*
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    pageInd.value == 1 ?
    GestureDetector(
      onTap: () {
        setOnboard();
        Get.toNamed('/signIn');
      },
      child: const Text(
        'Skip',
        style: TextStyle(
          color: MyPassColors.greyDarker,
          fontWeight: FontWeight.w700
        ),
      ),
    )
    :
    const SizedBox( width: 12),

    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.3 
      ),
      child: ProgressIndicator(currentPage: pageInd.value),
    ),
    
    pageInd.value < 3 ?
    GestureDetector(
      onTap: () => pageInd.value += 1,
      child: const Text(
        'Next',
        style: TextStyle(
          color: MyPassColors.blueLight,
          fontWeight: FontWeight.w700
        ),
      ),
    )
    :
    GestureDetector(
      onTap: () async {
        await setOnboard();
        Get.offAllNamed('/signIn');
      },
      child: const Text(
        'Login',
        style: TextStyle(
          color: MyPassColors.blueLight,
          fontWeight: FontWeight.w700
        ),
      ),
    ),
  ],
)
*/

class ProgressIndicator extends StatelessWidget {
  final double currentPage;

  ProgressIndicator({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDot(1),
        const SizedBox(width: 10), // Espaçamento entre os pontos
        buildDot(2),
        const SizedBox(width: 10), // Espaçamento entre os pontos
        buildDot(3),
      ],
    );
  }

  Widget buildDot(int pageNumber) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: pageNumber == currentPage ? MyPassColors.blueLight : MyPassColors.greyBD, // Altere as cores conforme necessário
      ),
    );
  }
}