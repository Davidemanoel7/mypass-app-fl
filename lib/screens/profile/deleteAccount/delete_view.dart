import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/profile/deleteAccount/delete_control.dart';
import 'package:mypass/utils/inputValidation.dart';
import 'package:mypass/utils/themes.dart';

class DeleteView extends StatelessWidget {
  DeleteView({super.key});

  final TextEditingController passEditControl = TextEditingController();
  final validInput = ValidationInput();

  final DeleteControll deleteControll = Get.put(DeleteControll());

  @override
  Widget build(BuildContext context) {
    var showPass = false.obs;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,  
          elevation: 0,
          title: Text(
            'Encerrar conta',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atenção! essa ação é irreversível!',
                  style: MyPassFonts.style.kTitleMedium(context,
                    color: MyPassColors.redAlert
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Ao encerrar sua conta, todos os seus dados serão excluídos permanentemente.',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Caso queiras completar essa ação, digite a senha da sua conta...',
                    style: MyPassFonts.style.kLabelSmall(context,
                      color: MyPassColors.black1B
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Obx(() => 
                      TextFormField(
                        controller: passEditControl,
                        decoration: InputDecoration(
                          prefixIcon: const Icon( Icons.lock_open_outlined ),
                          suffixIcon:
                            IconButton(
                              icon: Icon(
                                Icons.remove_red_eye_outlined,
                                color: showPass.value
                                  ? MyPassColors.blueLight
                                  : MyPassColors.greyBD,
                              ),
                              onPressed: () {
                                showPass(!showPass.value);
                              },
                            ),
                          hintText: 'Informe a senha da conta',
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
                        obscureText: !showPass.value,
                        textInputAction: TextInputAction.done,
                        validator: (value) => ValidationInput().validatePass(value),
                        onChanged: (value) {
                          if ( ValidationInput().validatePass(value) == null ) {
                            deleteControll.valid(true);
                          } else {
                            deleteControll.valid(false);
                          }
                        },
                      )
                    )
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() => deleteControll.loadRequest.value ?
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: MyPassColors.redAlert,
                              ),
                            ],
                          )
                        :
                          Obx(() => 
                            ElevatedButton(
                              onPressed: deleteControll.valid.value ?
                                () async {
                                  Map<String,dynamic> result = await deleteControll.checkSecurity( passEditControl.value.text );
                                  if ( result['auth']){
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        surfaceTintColor: MyPassColors.whiteF0,
                                        title: Text(
                                          'Cuidado! Esta ação é irreversível',
                                          style: MyPassFonts.style.kTitleMedium(context,
                                            color: MyPassColors.redAlert,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        content: Text(
                                          'Esta ação apagará todos os seus dados. Deseja mesmo continuar?',
                                          style: MyPassFonts.style.kLabelMedium(context,
                                            color: MyPassColors.black1B,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              'cancelar',
                                              style: MyPassFonts.style.kTitleLarge(context,
                                                color: MyPassColors.greyBD,
                                                fontSize: 16
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                bool result = await deleteControll.deleteAccount();
                                                if ( result ) {
                                                  Get.snackbar(
                                                    "",
                                                    "",
                                                    titleText: Text(
                                                      'Conta excluída com sucesso 😔',
                                                      style: MyPassFonts.style.kLabelLarge(context,
                                                        fontWeight: FontWeight.bold,
                                                        color: MyPassColors.purpleLight,
                                                      ),
                                                    ),
                                                    messageText: Text(
                                                      'Sua conta foi excluída da base de dados... Até a próxima 😆',
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
                                                  Get.offAllNamed('/signIn');
                                                } else {
                                                  Get.snackbar(
                                                    "",
                                                    "",
                                                    titleText: Text(
                                                      'Oops',
                                                      style: MyPassFonts.style.kLabelLarge(context,
                                                        fontWeight: FontWeight.bold,
                                                        color: MyPassColors.redAlert,
                                                      ),
                                                    ),
                                                    messageText: Text(
                                                      'Algo de errado aconteceu...',
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
                                              child: Text(
                                                'encerrar',
                                                style: MyPassFonts.style.kTitleLarge(context,
                                                  color: MyPassColors.redAlert,
                                                  fontSize: 16
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    Get.snackbar(
                                      "Senha incorreta",
                                      "",
                                      titleText: Text(
                                        'Senha incorreta',
                                        style: MyPassFonts.style.kLabelLarge(context,
                                          fontWeight: FontWeight.bold,
                                          color: MyPassColors.redAlert,
                                        ),
                                      ),
                                      messageText: Text(
                                        '${result['message']}',
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
                                }
                              :
                                null,
                              style: deleteControll.valid.value ?
                                ElevatedButton.styleFrom(
                                  backgroundColor: MyPassColors.redAlert,
                                  alignment: Alignment.center,
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width,
                                    56.0
                                  ),
                                )
                                :
                                ElevatedButton.styleFrom(
                                  backgroundColor: MyPassColors.greyBD,
                                  alignment: Alignment.center,
                                  fixedSize: Size(
                                    MediaQuery.of(context).size.width,
                                    56.0
                                  ),
                                )
                              ,
                              child: Text(
                                'Encerrar',
                                style: deleteControll.valid.value ? 
                                  const TextStyle(
                                    color: MyPassColors.whiteF0,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                                  :
                                  const TextStyle(
                                    color: MyPassColors.greyDarker,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                              )
                            )
                          )
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