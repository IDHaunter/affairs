import 'package:affairs/theme/common/theme.dart';
import 'package:flutter/material.dart';

class DarkTheme extends ITheme {
  static final DarkTheme _theme = DarkTheme._internal();

  factory DarkTheme() {
    return _theme;
  }

  DarkTheme._internal();

  final Color _primary = const Color(0xFF1F2125);
  final Color _secondary = const Color(0xFF2A2C30);
  final Color _accent = const Color(0xFF19B155);
  final Color _majorShadow = const Color(0x2919B155);
  final Color _textPrimary = const Color(0xFFFFFFFF);
  final Color _textSecondary = const Color(0x80FFFFFF);
  final Color _icon = const Color(0x9919B155);
  final Color _dark = const Color(0xFF131E17);
  final Color _failure = const Color(0xFFFF0000);
  final Color _success = const Color(0xFF19B155);
  final Color _grey = const Color(0xFFE4DCFB);
  final Color _buttonText = const Color(0xFFFFFFFF);

  late final Gradient _accentGradient = LinearGradient(
    colors: [_accent, const Color(0xFF8BCE49), const Color(0xFFFFEB3D)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  late final Gradient _accentGradientVertical = LinearGradient(
    colors: [_accent, const Color(0xFF8BCE49), const Color(0xFFFFEB3D)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  @override
  Color quickSelectionBackground() => const Color(0x802A2C30);

  @override
  Color quickSelectionText() => const Color(0x80FFFFFF);

  @override
  Color accent() => _accent;

  @override
  Gradient accentGradient() => _accentGradient;

  @override
  Gradient accentGradientVertical() => _accentGradientVertical;

  @override
  Gradient backspaceGradient() => _accentGradient;

  @override
  Color dark() => _dark;

  @override
  Color failure() => _failure;

  @override
  Color grey() => _grey;

  @override
  Color unreadNotification() => const Color(0xFFB11919);

  @override
  Color primary() => _primary;

  @override
  Color secondary() => _secondary;

  @override
  Color success() => _success;

  @override
  Color textPrimary() => _textPrimary;

  @override
  Color textSecondary() => _textSecondary;

  @override
  String logoAsset() => "assets/images/splash_logo_dark.png";

  @override
  Color majorShadow() => _majorShadow;

  @override
  Color icon() => _icon;

  @override
  Color buttonText() => _buttonText;

  @override
  Color altButton() => _accent;

  @override
  Color altButtonText() => Colors.white;
}
