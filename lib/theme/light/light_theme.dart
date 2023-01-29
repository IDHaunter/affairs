import 'package:affairs/theme/common/theme.dart';
import 'package:flutter/material.dart';

class LightTheme extends ITheme {
  static final LightTheme _theme = LightTheme._internal();

  factory LightTheme() {
    return _theme;
  }

  LightTheme._internal();

  final Color _primary = const Color(0xFFEA2F8D);
  final Color _secondary = const Color(0xFFFFFFFF);
  final Color _accent = const Color(0xFFFF4081);
  final Color _majorShadow = const Color(0x4FD2348D);
  final Color _textPrimary = const Color(0xFF131E17);
  final Color _textSecondary = const Color(0x80131E17);
  final Color _icon = const Color(0xFFFFFFFF);
  final Color _dark = const Color(0xFF131E17);
  final Color _failure = const Color(0xFFFF0059);
  final Color _success = const Color(0xFFA3FF40);
  final Color _grey = const Color(0xFFE4DCFB);
  final Color _buttonText = const Color(0xFFFFFFFF);

  late final Gradient _accentGradient = LinearGradient(
    colors: [_accent, const Color(0xFFE91E63), const Color(0x1BFF4081)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  late final Gradient _accentGradientVertical = LinearGradient(
    colors: [_accent, const Color(0xFFE91E63), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  late final Gradient _backspaceGradient = LinearGradient(
    colors: [_accent, const Color(0x80131E17), const Color(0x80131E17)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Color quickSelectionBackground() => const Color(0x4D19242D);

  @override
  Color quickSelectionText() => const Color(0xFFFFFFFF);

  @override
  Color accent() => _accent;

  @override
  Gradient accentGradient() => _accentGradient;

  @override
  Gradient accentGradientVertical() => _accentGradientVertical;

  @override
  Gradient backspaceGradient() => _backspaceGradient;

  @override
  Color unreadNotification() => const Color(0xFFB11919);

  @override
  Color dark() => _dark;

  @override
  Color failure() => _failure;

  @override
  Color grey() => _grey;

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
  String logoAsset() => "assets/images/splash_logo_light.png";

  @override
  Color majorShadow() => _majorShadow;

  @override
  Color icon() => _icon;

  @override
  Color buttonText() => _buttonText;

  @override
  Color altButton() => _secondary;

  @override
  Color altButtonText() => _accent;
}
