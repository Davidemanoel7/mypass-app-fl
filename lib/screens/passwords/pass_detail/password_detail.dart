import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/passwords/pass_detail/pass_detail_controller.dart';
import 'package:mypass/utils/themes.dart';

// ignore: must_be_immutable
class PasswordDetail extends StatelessWidget {
  PasswordDetail({
    super.key,
  });

  PassDetailController passControl = Get.put( PassDetailController( pass: Rx(Get.arguments['pass'])));
  TextEditingController urlTextCtrl = TextEditingController( text: Rx(Get.arguments['pass']).value.url);
  TextEditingController descriptionTextCtrl = TextEditingController(text: Rx(Get.arguments['pass']).value.description);
  TextEditingController passTextCtrl = TextEditingController(text: Rx(Get.arguments['pass']).value.password);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,  
          elevation: 0,
          title: Text(
            'Minha senha',
            style: MyPassFonts.style.kLabelMedium(context,
              color: MyPassColors.black1B,
              fontWeight: FontWeight.w700
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: () async {
                  bool resultDelete = await passControl.deletePassword();
                  if ( resultDelete ) {
                    Get.back();
                    showSnack(
                      context,
                      'Senha excluída',
                      MyPassColors.purpleLight, 
                      'Sua senha foi excluída com sucesso!',
                      MyPassColors.redAlert
                    );
                  } else {
                    showSnack(
                      context,
                      'Oops...',
                      MyPassColors.purpleLight, 
                      'Algo de errado aconteceu e sua senha não foi excluída... Tente novamente!',
                      MyPassColors.redAlert
                    );
                  }
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: MyPassColors.redAlert,
                )
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: 
                Form(
                  child: TextFormField(
                    controller: passTextCtrl,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      alignLabelWithHint: true,
                      suffixIcon: IconButton(
                        onPressed: () async {
                          await Clipboard.setData( ClipboardData( text: passTextCtrl.text )).then((_) => 
                            Get.snackbar(
                              "",
                              "",
                              titleText: Text(
                                'Copiado',
                                style: MyPassFonts.style.kLabelLarge(context,
                                  fontWeight: FontWeight.bold,
                                  color: MyPassColors.purpleLight,
                                ),
                              ),
                              messageText: Text(
                                'Senha copiada para a área de transferência',
                                style: MyPassFonts.style.kLabelSmall(context,
                                  fontWeight: FontWeight.w400,
                                  color: MyPassColors.black1B
                                ),
                              ),
                              colorText: MyPassColors.black1B,
                              leftBarIndicatorColor: MyPassColors.purpleLight,
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
                            )
                          );
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: MyPassColors.blueLight,
                        )
                      ),
                      labelStyle: MyPassFonts.style.kLabelSmall( context,
                        color: MyPassColors.greyDarker
                      ),
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
                    validator: (value) {
                      return value!.isEmpty || value.length < 6 || value.length > 20 ?
                        'Deve ter entre 6 e 20 caracteres'
                        :
                        null;
                    },
                    onChanged: (value) {
                      if ( passControl.changed.isFalse ) passControl.changed(true);
                    },
                  ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Form(
                child: TextFormField(
                  controller: descriptionTextCtrl,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                    alignLabelWithHint: true,
                    labelStyle: MyPassFonts.style.kLabelSmall( context,
                      color: MyPassColors.greyDarker
                    ),
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
                  validator: (value) {
                    return value!.isEmpty ?
                      'Preenchimento obrigatório'
                      :
                      null;
                  },
                  onChanged: (value) {
                    if ( passControl.changed.isFalse ) passControl.changed(true);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: urlTextCtrl,
                decoration: InputDecoration(
                  labelText: 'Link',
                  alignLabelWithHint: true,
                  labelStyle: MyPassFonts.style.kLabelSmall( context,
                    color: MyPassColors.greyDarker
                  ),
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
                keyboardType: TextInputType.url,
                // onChanged: (value) => savePassControll.url(value),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(()=> passControl.isLoad.value
                  ? const CircularProgressIndicator(
                      color: MyPassColors.purpleLight,
                    )
                  : ElevatedButton(
                      onPressed: passControl.changed.isFalse
                      ? null
                      : () async {
                        bool requestResult = await passControl.changePass(
                          description: descriptionTextCtrl.text,
                          password: passTextCtrl.text,
                          url: urlTextCtrl.text
                        );
                        if ( requestResult ){
                          passControl.changed(false);
                          showSnack(
                            context,
                            'Sucesso',
                            MyPassColors.purpleLight,
                            'Alteramos os dados de sua senha',
                            MyPassColors.purpleLight
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: passControl.changed.isFalse ?
                            MyPassColors.greyBD
                            :
                            MyPassColors.purpleLight,
                          alignment: Alignment.center,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            56.0
                          ),
                        ),
                      child: Text(
                        'Editar senha',
                        style: TextStyle(
                          color: passControl.changed.isFalse
                            ? MyPassColors.greyDarker
                            : MyPassColors.whiteF0,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      )
                    )
                  )
                ],
              ) 
            )
          ],
          )
        ),
      )
    );
  }

  dynamic showSnack(
    BuildContext context,
    String title,
    Color titleColor,
    String message,
    Color leftBarIndicatorColor ) {
      return Get.snackbar(
        "",
        "",
        titleText: Text(
          title,
          style: MyPassFonts.style.kLabelLarge(
            context,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        messageText: Text(
          message,
          style: MyPassFonts.style.kLabelSmall(context,
            fontWeight: FontWeight.w400,
            color: MyPassColors.black1B
          ),
        ),
        colorText: MyPassColors.black1B,
        leftBarIndicatorColor: leftBarIndicatorColor,
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
}