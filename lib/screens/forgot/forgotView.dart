import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/forgot/forgotControll.dart';
import 'package:mypass/utils/themes.dart';

class ForgorView extends StatelessWidget {
  ForgorView({super.key});

  final TextEditingController emailEditControl = TextEditingController();
  final ForgotControll forgotControll = Get.put(ForgotControll());

  @override
  Widget build(BuildContext context) {
    RxBool send = false.obs;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0,
        title: Text(
          'Recuperar senha',
          style: MyPassFonts.style.kTitleMedium(context,
            color: MyPassColors.greyDarker,
            fontWeight: FontWeight.w700
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Image.asset(
                    './lib/assets/images/myPass.png'  
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    'Enviaremos um link de recuperação para o e-mail da sua conta, basta informá-lo abaixo...',
                    style: MyPassFonts.style.kLabelMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailEditControl,
                      decoration: InputDecoration(
                        prefixIcon: const Icon( Icons.email_outlined ),
                        hintText: 'Digite o email da sua conta',
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
                      textInputAction: TextInputAction.send,
                      validator: (value) {
                        if( !value!.isEmail ) {
                          return 'Digite um email válido';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if ( value.isEmail ) {
                          forgotControll.emailValid(true);
                        } else {
                          forgotControll.emailValid(false);
                        }
                      },
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 8),
                  child:
                    Obx(() => 
                      forgotControll.forgotLoad.value ?
                      const CircularProgressIndicator(
                        color: MyPassColors.purpleLight,
                      )
                      :
                      ElevatedButton(
                        onPressed: forgotControll.emailValid.value ?
                        () async {
                          String email = emailEditControl.value.text;
                          Map<String, dynamic> result = await forgotControll.forgot( email );
                          send(true);
                          if ( result['sended'] == true ){
                            Get.bottomSheet(
                              BottomSheet(
                                onClosing: (){},
                                builder: (_) =>
                                  Container(
                                    width: context.width,
                                    height: context.height * 0.3,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all( Radius.circular(32) ),
                                      color: MyPassColors.whiteF0,
                                    ),
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Enviado!',
                                          style: TextStyle(
                                            color: MyPassColors.purpleLight,
                                            fontSize: 20
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(
                                            'Enviamos um link de recuperação para seu email. Verifique sua caixa de entrada e altere sua senha. [O link expira em 1 hora]',
                                            style: TextStyle(
                                              color: MyPassColors.black1B,
                                              fontSize: 16
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: Size(
                                                context.width - 48,
                                                64
                                              ),
                                              backgroundColor: MyPassColors.purpleLight
                                            ),
                                            child: Text(
                                              'Ok',
                                              style: MyPassFonts.style.kLabelLarge(
                                                context,
                                                color: MyPassColors.whiteF0,
                                              ),
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              )
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
                        : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: forgotControll.emailValid.value
                          ?MyPassColors.purpleLight
                          : MyPassColors.greyBD,
                          alignment: Alignment.center,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            56.0
                          ),
                        ),
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                            color: forgotControll.emailValid.value
                            ? MyPassColors.whiteF0
                            : MyPassColors.greyDarker,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}