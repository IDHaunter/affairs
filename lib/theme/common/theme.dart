import 'package:flutter/material.dart';

abstract class ITheme {

  Color quickSelectionText();

  Color primary();

  Color secondary();

  Color accent();

  Color majorShadow();

  Color textPrimary();

  Color textSecondary();

  Color icon();

  Color failure();

  Color unreadNotification();

  Color success();

  Color grey();

  Color buttonText();

  Gradient accentGradient();

  Gradient accentGradientVertical();

  Gradient backspaceGradient();

  String logoAsset();
}
