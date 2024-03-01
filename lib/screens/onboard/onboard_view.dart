import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/onboard/onboard_controll.dart';
import 'package:mypass/utils/themes.dart';


class OnboardView extends StatelessWidget {
  OnboardView({super.key});

  final OnboardControl _onboardControl = Get.put(OnboardControl());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsetsDirectional.all(24),
          child: Obx(
          () => 
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                changePage(_onboardControl.pageIndex.value),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _onboardControl.pageIndex.value == 1 ?
                    GestureDetector(
                      onTap: () {
                        _onboardControl.setOnboard();
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
                    const SizedBox( width: 12,),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.3 
                      ),
                      child: ProgressIndicator(currentPage: _onboardControl.pageIndex.value),
                    ),
                    
                    _onboardControl.pageIndex.value < 3 ?
                    GestureDetector(
                      onTap: () => _onboardControl.pageIndex.value += 1,
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: MyPassColors.blueLight,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ) :
                    GestureDetector(
                      onTap: () => {
                        _onboardControl.setOnboard(),
                        Get.offAllNamed('/signIn')
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
              ],
            )
          ) 
        ),
    );
  }
}


Widget changePage( int index ){
  switch ( index ) {
    case 1:
      return Container(
        margin: const EdgeInsets.all(24),
        child:  const Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric( vertical: 24 ),
              child: Image(
                image: AssetImage('./lib/assets/images/selected.png'),
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric( vertical: 48 ),
              child: Text(
                'Selecione as propriedades da senha a ser gerada...',
                style: TextStyle(
                  color: MyPassColors.greyDarker,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ),
            )
            // Text('$index/3')
          ],
        ) 
      );
    case 2:
      return Container(
        margin: const EdgeInsets.all(24),
        child: const Column(
          children: [
            

            Padding(
              padding: EdgeInsets.symmetric( vertical: 24),
              child: Text(
                'Gere uma senha aleatória e então salve ela no seu banco de senhas.',
                style: TextStyle(
                  color: MyPassColors.greyDarker,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              )
            ),
            
            Padding(
              padding: EdgeInsets.symmetric( vertical: 24 ),
              child: Image(
                image: AssetImage('./lib/assets/images/random.png'),
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.symmetric( vertical: 48),
              child: Text(
                '...suas senhas serão guardadas criptografadas',
                style: TextStyle(
                  color: MyPassColors.greyDarker,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ),
            ),
          ]
        ),
      );
    case 3:
      return Container(
        margin: const EdgeInsets.all(24),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric( vertical: 48 ),
              child: Image(
                image: AssetImage('./lib/assets/images/shield.png'),
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric( vertical: 24),
              child: Text(
                'Proteja seu banco de senha com autenticação...',
                style: TextStyle(
                  color: MyPassColors.greyDarker,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ), 
            ),
            
            Padding(
              padding: EdgeInsets.symmetric( vertical: 24),
              child: Text(
                'Somente você terá acesso!',
                style: TextStyle(
                  color: MyPassColors.greyDarker,
                  fontWeight: FontWeight.w400,
                  fontSize: 16
                ),
              ), 
            ),
          ]
        ),
      );
    default:
      return Container();
  }
}

class ProgressIndicator extends StatelessWidget {
  final int currentPage;

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