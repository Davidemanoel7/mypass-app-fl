import 'package:flutter/material.dart';

class MyPassColors {
  static const blueLight = Color(0xFF64B1F6);
  static const purpleLight = Color(0xFF9F40ED);
  static const whiteF0 = Color(0xFFF0F0F0);
  static const greyBD = Color(0xFFBDBDBD);
  static const greyDarker = Color(0xFF565656);
  static const black1B = Color(0xFF1B1B1B);
  static const redAlert = Color(0xFFCF402D);
  static const greenSucess = Color(0xFF19A437);
}

class MyPassFonts {
  MyPassFonts._privateContructor();

  static final style = MyPassFonts._privateContructor();

  TextStyle? kTitleLarge(BuildContext context,
          {Color color = MyPassColors.black1B, double fontSize =  22 }) =>
      Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w900, fontSize: fontSize, color: color);

  TextStyle? kTitleMedium(BuildContext context,
          {Color color = MyPassColors.black1B, FontWeight fontWeight = FontWeight.w500}) =>
      Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: fontWeight, fontSize: 18, color: color);

  TextStyle? kLabelLarge(BuildContext context,
          {Color color = MyPassColors.black1B, FontWeight fontWeight = FontWeight.normal}) =>
      Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: fontWeight, fontSize: 16, color: color);

  TextStyle? kLabelMedium(BuildContext context,
          {Color color = MyPassColors.black1B, FontWeight fontWeight = FontWeight.normal}) =>
      Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(fontWeight: fontWeight, fontSize: 14, color: color);

  TextStyle? kLabelSmall(BuildContext context,
          {Color color = MyPassColors.greyDarker, FontWeight fontWeight = FontWeight.normal}) =>
      Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(fontWeight: fontWeight, fontSize: 12, color: color);
}