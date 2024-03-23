import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/passwords/create/create_pass_control.dart';
import 'package:mypass/utils/themes.dart';

class PasswordView extends StatelessWidget {
  PasswordView({super.key});

  final TextEditingController passEditingControl = TextEditingController();

  final CreatePassControl createPassControl = Get.put(CreatePassControl());


  MaterialStateProperty<Color> getTrackBorderColor() {
    return MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        // Cor quando o switch está desativado
        return MyPassColors.purpleLight.withOpacity(0.1);
      } 
      // Cor padrão para outros estados
      return MyPassColors.greyBD;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0,
        title: Text(
          'Nova senha',
          style: MyPassFonts.style.kLabelMedium(context,
            color: MyPassColors.black1B,
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => Get.toNamed('/helpPass'),
              icon: const Icon(
                Icons.help_outline_rounded,
                color: MyPassColors.greyBD,
              )
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Digite ou gere uma nova senha',
                style: MyPassFonts.style.kLabelLarge(context,
                  color: MyPassColors.blueLight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextFormField(
                controller: passEditingControl,
                decoration: InputDecoration(
                  hintText: 'Digite ou clique no botão ao lado',
                  hintStyle: MyPassFonts.style.kLabelSmall(context,
                    color: MyPassColors.greyBD,
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      passEditingControl.text = createPassControl.generatePass();
                    },
                    icon: const Icon(Icons.replay_rounded,
                      color: MyPassColors.blueLight,
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: MyPassColors.blueLight,
                      width: 1.0,
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Obx(() => 
                Column(
                  children: [
                    Text('Escolha um tamanho para sua senha: ${createPassControl.sliderValue.value.toInt()}'),
                    Slider(
                      value: createPassControl.sliderValue.value,
                      onChanged: ( double value ) {
                        if ( value < 6 ) {
                          createPassControl.sliderValue(6);
                        } else {
                          createPassControl.sliderValue(value);
                        }
                      },
                      max: 20.0,
                      divisions: 10,
                      label: createPassControl.sliderValue.value.toString(),
                      allowedInteraction: SliderInteraction.tapAndSlide,
                      activeColor: MyPassColors.purpleLight,
                    ),
                  ],
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Numbers(0123456789)',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.greyDarker
                    ),
                  ),
                  Obx(() =>
                    Switch(
                      value: createPassControl.numbers.value,
                      onChanged: ( bool value ) {
                        createPassControl.numbers(value);
                      },
                      activeColor: MyPassColors.whiteF0.withOpacity(0.2),
                      activeTrackColor: MyPassColors.purpleLight,
                      inactiveThumbColor: MyPassColors.greyBD,
                      trackOutlineColor: getTrackBorderColor(),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special (!@#_*)',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.greyDarker
                    ),
                  ),
                  Obx( () =>
                    Switch(
                      value: createPassControl.special.value,
                      onChanged: ( bool value ) {
                        createPassControl.special(value);
                      },
                      activeColor: MyPassColors.whiteF0.withOpacity(0.2),
                      activeTrackColor: MyPassColors.purpleLight,
                      inactiveThumbColor: MyPassColors.greyBD,
                      trackOutlineColor: getTrackBorderColor(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'UPPERCASE',
                    style: MyPassFonts.style.kLabelMedium(context,
                      color: MyPassColors.greyDarker
                    ),
                  ),
                  Obx(() => 
                    Switch(
                      value: createPassControl.uppercase.value,
                      onChanged: ( bool value ) {
                        createPassControl.uppercase(value);
                      },
                      activeColor: MyPassColors.whiteF0.withOpacity(0.2),
                      activeTrackColor: MyPassColors.purpleLight,
                      inactiveThumbColor: MyPassColors.greyBD,
                      trackOutlineColor: getTrackBorderColor(),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/savePass', 
                      arguments: {
                        "pass": passEditingControl.text
                      }
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyPassColors.purpleLight,
                      alignment: Alignment.center,
                      fixedSize: Size(
                        MediaQuery.of(context).size.width,
                        56.0
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        color: MyPassColors.whiteF0,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ) 
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}