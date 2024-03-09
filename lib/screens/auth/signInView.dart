import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInControll.dart';
import 'package:mypass/utils/inputValidation.dart';
import 'package:mypass/utils/themes.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final signInControl = Get.put(SignInControl());

  final emailEditControl = TextEditingController();
  final senhaEditControl = TextEditingController();

  final validInput = ValidationInput();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Image.asset(
                    './lib/assets/images/myPass.png'  
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailEditControl,
                      style: const TextStyle(
                        // backgroundColor: Colors.white10,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon( Icons.email_outlined ),
                        hintText: 'Digite seu email',
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
                      validator: (value) => validInput.validationMessage( ValidationType.email, value! ),
                      onChanged: (value) {
                        if ( value.isEmail ){
                          signInControl.isEmailValid(true);
                        } else {
                          signInControl.isEmailValid(false);
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      clipBehavior: Clip.antiAlias,
                      controller: senhaEditControl,
                      style: const TextStyle(
                        backgroundColor: Colors.white10,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon( Icons.lock_open_outlined ),
                        hintText: 'Digite sua senha',
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
                      obscureText: true,
                      validator: (value) => validInput.validationMessage( ValidationType.senha, value! ),
                      onChanged: (value) {
                        if (RegExp(r'^[a-zA-Z0-9_!@#.$]{6,20}$').hasMatch(value)){
                          signInControl.isPassValid(true);
                        } else {
                          signInControl.isPassValid(false);
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: GestureDetector(
                    onTap: () => debugPrint('esqueci minha senha'),
                    child: Text(
                      'Esqueci minha senha',
                      style: MyPassFonts.style.kLabelSmall(context,
                        fontWeight: FontWeight.w500,
                        color: MyPassColors.greyBD
                      ),
                    ),
                  )
                ),
                Obx(() => 
                  signInControl.authLoad.value ?
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
                        signInControl.isEmailValid.value && signInControl.isPassValid.value ? 
                        ElevatedButton(
                          onPressed: () async {
                            String email = emailEditControl.value.text;
                            String senha = senhaEditControl.value.text;
                            dynamic result = await signInControl.logIn( email, senha );
                            if ( result['auth'] == true ) {
                              Get.toNamed('/home');
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
                            'Login',
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
                            'Login',
                            style: TextStyle(
                              color: MyPassColors.greyDarker,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ) 
                      )
                    ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Text(
                        'Não tem conta?',
                        style: MyPassFonts.style.kLabelSmall(context,
                          fontWeight: FontWeight.w500,
                          color: MyPassColors.greyBD
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => debugPrint('criar conta'), //Get.toNamed(),
                      child: Text(
                        'Crie agora',
                        style: MyPassFonts.style.kLabelSmall(context,
                          fontWeight: FontWeight.bold,
                          color: MyPassColors.blueLight
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}