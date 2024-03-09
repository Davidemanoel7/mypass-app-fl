import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signUpControll.dart';
import 'package:mypass/utils/inputValidation.dart';
import 'package:mypass/utils/themes.dart';

class SignUpView extends StatelessWidget{
  SignUpView({super.key});

  final SignUpControl signUpControl = Get.put(SignUpControl());

  final TextEditingController nomeEditControl = TextEditingController();
  final TextEditingController userEditControl = TextEditingController();
  final TextEditingController emailEditControl = TextEditingController();
  final TextEditingController senhaEditControl = TextEditingController();

  final validInput = ValidationInput();

  @override
  Widget build(BuildContext context) {
    return(
      Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 36),
                    child: Image.asset(
                      './lib/assets/images/myPass.png'  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        controller: nomeEditControl,
                        style: const TextStyle(
                        // backgroundColor: Colors.white10,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon( Icons.person_outline_sharp ),
                          hintText: 'Digite seu nome completo',
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
                        validator: (value) {
                          if ( value!.isEmpty ) {
                            return 'Nome de usuário não pode ser nulo';
                          } else if ( value.length < 4 || value.length > 100) {
                            return 'São aceitos apenas nomes entre 4 e 100 caracteres';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          if ( value.isNotEmpty && value.length >= 4 || value.length <= 100 ){
                            signUpControl.isNameValid(true);
                          } else {
                            signUpControl.isNameValid(false);
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
                        controller: userEditControl,
                        style: const TextStyle(
                        // backgroundColor: Colors.white10,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: const Icon( Icons.manage_accounts_sharp ),
                          hintText: 'Digite um nome de usuário',
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
                        validator: (value) {
                          if ( value!.isEmpty ) {
                            return 'Nome de usuário não pode ser nulo';
                          } else if ( value.length < 4 || value.length > 20 ) {
                            return 'São aceitos apenas nomes entre 4 e 20 caracteres';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          if ( value.isNotEmpty && value.length >= 4 || value.length <= 20 ){
                            signUpControl.isUserValid(true);
                          } else {
                            signUpControl.isUserValid(false);
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
                            signUpControl.isEmailValid(true);
                          } else {
                            signUpControl.isEmailValid(false);
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
                            signUpControl.isPassValid(true);
                          } else {
                            signUpControl.isPassValid(false);
                          }
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Já tenho conta',
                      style: MyPassFonts.style.kLabelSmall(context,
                        color: MyPassColors.blueLight,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Obx(() => signUpControl.signUpLoad.value ?
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
                        signUpControl.isEmailValid.value &&
                        signUpControl.isPassValid.value &&
                        signUpControl.isNameValid.value &&
                        signUpControl.isUserValid.value
                        ? 
                        ElevatedButton(
                          onPressed: () async {
                            String email = emailEditControl.value.text;
                            String senha = senhaEditControl.value.text;
                            String user = userEditControl.value.text;
                            String name = nomeEditControl.value.text;
                            dynamic result = await signUpControl.signUp( name, user, email, senha );
                            if ( result['created'] == true ) {
                              Get.snackbar(
                                "Oops",
                                "",
                                titleText: Text(
                                  'Wellcome 💙',
                                  style: MyPassFonts.style.kLabelLarge(context,
                                    fontWeight: FontWeight.bold,
                                    color: MyPassColors.purpleLight,
                                  ),
                                ),
                                messageText: Text(
                                  'Hi, $user. Confirm your email on settings!',
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
                              Future.delayed(Duration(seconds: 5));
                              Get.offAndToNamed('/home');
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
                            'Criar conta',
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
                            'Criar conta',
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
              ),
            ),
          ),  
        ),
      )
    );
  }
  
}