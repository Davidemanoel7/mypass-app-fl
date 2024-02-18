import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypass/screens/auth/signInControll.dart';
import 'package:mypass/utils/inputValidation.dart';
import 'package:mypass/utils/themes.dart';
import 'package:mypass/widgets/components/BasicForm.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final signInControl = Get.put(SignInControl());

  final emailEditControl = TextEditingController();
  final senhaEditControl = TextEditingController();

  final validInput = ValidationInput();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24.0),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              './lib/assets/images/myPass.png'  
            ),
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                controller: emailEditControl,
                style: const TextStyle(
                  backgroundColor: Colors.white10,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon( Icons.email_outlined ),
                  hintText: 'Digite seu email',
                  hintStyle: MyPassFonts.style.kLabelSmall(context, color: const Color.fromARGB(73, 0, 0, 0)),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  fillColor: Colors.white54,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyPassColors.purpleLight,
                      width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusColor: MyPassColors.purpleLight,
                ),
                textInputAction: TextInputAction.done,
                validator: (value) => validInput.validationMessage( ValidationType.email, value! ),
                onChanged: (value) {
                  if (value.isEmail){
                    signInControl.isEmailValid(true);
                  }
                },
              ),
            ),

            Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                controller: senhaEditControl,
                style: const TextStyle(
                  backgroundColor: Colors.white10,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon( Icons.lock_open_outlined ),
                  hintText: 'Digite sua senha',
                  hintStyle: MyPassFonts.style.kLabelSmall(context, color: const Color.fromARGB(73, 0, 0, 0)),
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  fillColor: Colors.white54,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: MyPassColors.purpleLight,
                      width: 1.0
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusColor: MyPassColors.purpleLight,
                ),
                textInputAction: TextInputAction.done,
                validator: (value) => validInput.validationMessage( ValidationType.senha, value! ),
                onChanged: (value) {
                  if (RegExp(r'^[a-zA-Z0-9_!@#.$]{6,20}$').hasMatch(value)){
                    signInControl.isPassValid(true);
                  }
                },
              ),
            ),

            Obx(() => 
              ( signInControl.isEmailValid.value && signInControl.isPassValid.value )
              ? GestureDetector(
                onTap: (){
                  
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: MyPassColors.purpleLight,
                      radius: 24,
                      child: Icon(
                        Icons.arrow_forward,
                        color: MyPassColors.whiteF0,
                      ),
                    ),
                  ), 
                ),
              )
            : GestureDetector(
                onTap: (){
                  
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: MyPassColors.greyBD,
                      radius: 24,
                      child: Icon(
                        Icons.arrow_forward,
                        color: MyPassColors.black1B,
                      ),
                    ),
                  ), 
                ),
              )
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused))
                      return Colors.red;
                    return null; // Defer to the widget's default.
                  }
                ),
              ),
              onPressed: () {
                debugPrint('login');
              },
              child: Text('Login'),
            )
          ],
        ),
      )
    );
  }
}