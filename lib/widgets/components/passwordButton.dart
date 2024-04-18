import 'package:flutter/material.dart';
import 'package:mypass/utils/themes.dart';

class PasswordButton extends StatelessWidget {
  const PasswordButton({super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (){
        
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        splashFactory: NoSplash.splashFactory,
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
          Padding(
            padding: const EdgeInsets.symmetric( horizontal: 8, vertical: 12),
            child: Text(
              title,
              style: MyPassFonts.style.kLabelMedium(context,
                color: MyPassColors.greyDarker
              ),
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