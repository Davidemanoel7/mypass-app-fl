
import 'package:flutter/material.dart';
import 'package:mypass/utils/inputValidation.dart';
import 'package:mypass/utils/themes.dart';

class BasicForm extends StatelessWidget {
  BasicForm({super.key,
    required this.icon,
    this.myHintText,
    required this.validationType,
  });

  final Icon icon;
  final String? myHintText;

  final ValidationType validationType;

  final validationInput = ValidationInput();

  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            controller: textEditingController,
            style: const TextStyle(
              backgroundColor: Colors.white10,
            ),
            decoration: InputDecoration(
              prefixIcon: icon,
              hintText: myHintText,
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
            validator: (value) => validationInput.validationMessage( validationType, value! ),
            onChanged: (value) {
              
            },
          ),
        ),
      ],
    );
  }
}