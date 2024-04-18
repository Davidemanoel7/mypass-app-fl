import 'package:flutter/material.dart';
import 'package:mypass/models/pass_model.dart';
import 'package:mypass/utils/themes.dart';

class PasswordButton extends StatelessWidget {
  PasswordButton({super.key,
    required this.pass
  });

  Password pass;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        debugPrint('Go to router with ID: ${pass.id}');
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric( vertical: 8, horizontal: 12 ),
        splashFactory: NoSplash.splashFactory,
        fixedSize: Size(
          MediaQuery.of(context).size.width,
          64
        ),
        side: const BorderSide(
          width: 1.0,
          color: MyPassColors.greyDarker,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,        
        children: [
          Text(
            pass.description,
            style: MyPassFonts.style.kLabelMedium(context,
              color: MyPassColors.greyDarker
            ),
          ),
          const Icon(
            Icons.navigate_next_rounded,
            color: MyPassColors.blueLight,
            size: 32.0,
          )
        ],
      )
    );
  }
}