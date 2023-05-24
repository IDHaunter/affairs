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

  Color beforeFailure();

  Color unreadNotification();

  Color success();

  Color grey();

  Color buttonText();

  Gradient accentGradient();

  LinearGradient accentGradientVertical();

  Gradient backspaceGradient();

  String logoAsset();
}
