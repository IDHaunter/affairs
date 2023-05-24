import 'package:affairs/core/utils/context_utils.dart';
import 'package:flutter/material.dart';

//миксин тут для эксперимента
mixin DefaultBackColor {
  final int r=230;
  final int g=0;
  final int b=150;
}

class Style {
  // COMMON
  static const cardCornerRadius = 15.0;

  static double smallPadding(BuildContext context) => context.valueByPhoneSize(4, 6, 8, 8);

  static double mediumPadding(BuildContext context) => context.valueByPhoneSize(8, 10, 12, 12);

  static double mainPadding(BuildContext context) => context.valueByPhoneSize(14, 14, 16, 16);

  static double bigPadding(BuildContext context) => context.valueByPhoneSize(18, 20, 24, 24);

  static double safeAreaBottomPadding(BuildContext context) => context.valueByPhoneSize(12, 16, 20, 24);

  static double buttonHeight(BuildContext context) => context.valueByPhoneSize(38, 40, 46, 46);

  static double toggleButtonHeight(BuildContext context) => context.valueByPhoneSize(30, 32, 36, 36);

  static double textFieldHeight(BuildContext context) => context.valueByPhoneSize(54, 56, 60, 60);

  static double checkboxSize(BuildContext context) => context.valueByPhoneSize(24, 24, 28, 28);

  static double radioButtonSize(BuildContext context) => context.valueByPhoneSize(24, 24, 28, 28);

  static double drawerMenuItemHeight(BuildContext context) => context.valueByPhoneSize(56, 58, 64, 64);

  static double searchFieldHeight(BuildContext context) => context.valueByPhoneSize(36, 36, 40, 40);

  static double filterItemHeight(BuildContext context) => context.valueByPhoneSize(32, 36, 40, 40);

  static double serviceItemHeight(BuildContext context) => context.valueByPhoneSize(44, 48, 52, 52);

  static double fuelItemHeight(BuildContext context) => context.valueByPhoneSize(44, 48, 52, 52);

  static double radioItemHeight(BuildContext context) => context.valueByPhoneSize(44, 48, 52, 52);

  static double nonSelectableListItemHeight(BuildContext context) => context.valueByPhoneSize(54, 56, 60, 60);

  // DIALOG
  static double dialogBackgroundRadius(BuildContext context) => context.valueByPhoneSize(16, 18, 22, 22);

  static double dialogButtonHeight(BuildContext context) => buttonHeight(context);

  static double dialogButtonBottomSpace(BuildContext context) => context.valueByPhoneSize(32, 32, 40, 40);

  static double dialogButtonTopSpace(BuildContext context) => context.valueByPhoneSize(28, 28, 35, 35);

  static iconButtonSize(BuildContext context) => context.valueByPhoneSize(32, 36, 40, 40);

  static toolbarHeight(BuildContext context) => context.valueByPhoneSize(86, 90, 98, 98);
}
