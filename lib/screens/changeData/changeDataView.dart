import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/changeData/changeDataControl.dart';
import 'package:mypass/utils/themes.dart';

class ChangeDataView extends StatelessWidget {
  ChangeDataView({super.key});

  final TextEditingController dataEditControl = TextEditingController();

  final ChangeDataControl changeDataControl = Get.put(ChangeDataControl());

  @override
  Widget build(BuildContext context) {
    String? data = Get.parameters['AppBarTitle'];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,  
          elevation: 0,
          title: Text(
            'Alterar $data',
            style: MyPassFonts.style.kLabelMedium(context,
              color: MyPassColors.black1B,
              fontWeight: FontWeight.w700
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    clipBehavior: Clip.antiAlias,
                    controller: dataEditControl,
                    style: const TextStyle(
                      backgroundColor: Colors.white10,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Inserir novo dado aqui',
                      hintStyle: MyPassFonts.style.kLabelSmall(context, color: const Color.fromARGB(73, 0, 0, 0)),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: MyPassColors.greyBD,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                        borderRadius: BorderRadius.circular(16.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: MyPassColors.purpleLight,
                          width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if ( value!.isEmpty ) {
                        return 'O valor não pode ser nulo';
                      } else if ( value.length < 6 || value.length > 60 ) {
                        return 'Entre 6 e 60 caracteres';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (RegExp(r'^[a-zA-Z\s]{6,60}$').hasMatch(value)){
                        changeDataControl.validValue(true);
                      } else {
                        changeDataControl.validValue(false);
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => changeDataControl.loadRequest.value
                    ?
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(
                          color: MyPassColors.purpleLight,
                        ),
                      )
                    :
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Obx(() =>
                          changeDataControl.validValue.value ? 
                          ElevatedButton(
                            onPressed: () async {
                              String data = dataEditControl.value.text;
                              bool result = await changeDataControl.changeName( data );
                              if ( result == true ) {
                                dataEditControl.clear();
                                Get.back();
                                Get.snackbar(
                                  "Dado alterado",
                                  "",
                                  titleText: Text(
                                    'Dado alterado',
                                    style: MyPassFonts.style.kLabelLarge(context,
                                      fontWeight: FontWeight.bold,
                                      color: MyPassColors.purpleLight,
                                    ),
                                  ),
                                  messageText: Text(
                                    'Dado alterado com sucesso !',
                                    style: MyPassFonts.style.kLabelSmall(context,
                                      fontWeight: FontWeight.w400,
                                      color: MyPassColors.black1B
                                    ),
                                  ),
                                  colorText: MyPassColors.black1B,
                                  leftBarIndicatorColor: MyPassColors.greenSucess,
                                  animationDuration: const Duration( seconds: 1 ),
                                  backgroundColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                  borderWidth: 2,
                                  borderRadius: 16,
                                  borderColor: MyPassColors.whiteF0,
                                  isDismissible: true,
                                  dismissDirection: DismissDirection.horizontal,
                                  duration: const Duration( seconds: 4 ),
                                  forwardAnimationCurve: Curves.easeInOutQuad,
                                );
                              } else {
                                Get.snackbar(
                                  "Oops",
                                  "",
                                  titleText: Text(
                                    'Oops',
                                    style: MyPassFonts.style.kLabelLarge(context,
                                      fontWeight: FontWeight.bold,
                                      color: MyPassColors.purpleLight,
                                    ),
                                  ),
                                  messageText: Text(
                                    'Não foi possível alterar. Tente novamente...',
                                    style: MyPassFonts.style.kLabelSmall(context,
                                      fontWeight: FontWeight.w400,
                                      color: MyPassColors.black1B
                                    ),
                                  ),
                                  colorText: MyPassColors.black1B,
                                  leftBarIndicatorColor: MyPassColors.redAlert,
                                  animationDuration: const Duration( seconds: 1 ),
                                  backgroundColor: Colors.white,
                                  snackPosition: SnackPosition.TOP,
                                  borderWidth: 2,
                                  borderRadius: 16,
                                  borderColor: MyPassColors.whiteF0,
                                  isDismissible: true,
                                  dismissDirection: DismissDirection.horizontal,
                                  duration: const Duration( seconds: 4 ),
                                  forwardAnimationCurve: Curves.easeInOutQuad,
                                );
                              }
                            },
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
                          :
                          ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyPassColors.greyBD,
                              alignment: Alignment.center,
                              fixedSize: Size(
                                MediaQuery.of(context).size.width,
                                56.0
                              ),
                            ),
                            child: const Text(
                              'Salvar',
                              style: TextStyle(
                                color: MyPassColors.greyDarker,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ) 
                        )
                      ),
                    )
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