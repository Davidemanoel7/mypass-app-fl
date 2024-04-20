import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/passwords/saved/saved_controll.dart';
import 'package:mypass/utils/themes.dart';

class SaveSuccessView extends StatelessWidget {
  const SaveSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric( vertical: 48 ),
                child: Image(
                  image: AssetImage('./lib/assets/images/shield.png'),
                  height: 120,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 12 ),
                child: Text(
                  'Senha salva com sucesso!',
                  style: MyPassFonts.style.kLabelLarge(context,
                    color: MyPassColors.blueLight
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 12 ),
                child: Text(
                  '...você pode deletá-la ou escolher outra quando quiser, acessando seu banco de senhas.',
                  style: MyPassFonts.style.kLabelLarge(context,
                    color: MyPassColors.greyDarker
                  )
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric( vertical: 12 ),
                child: ElevatedButton(
                  onPressed: () {
                    SavedController savedController = Get.put(SavedController());
                    savedController.update();
                    Get.offAllNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyPassColors.purpleLight,
                    alignment: Alignment.center,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        56.0
                      ),
                  ),
                  child: Text(
                    'Ok',
                    style: MyPassFonts.style.kLabelLarge(context,
                      color: MyPassColors.whiteF0
                    ),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}