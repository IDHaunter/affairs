import 'package:affairs/core/common_export.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();
  final String authReason;

  LocalAuthService({required this.authReason});

  static Future<bool> checkBiometrics() async {
    try {
      //canCheckBiometrics - биометрические методы
      //isDeviceSupported - иные методы реализованные в устройстве
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      debugPrint('---- canCheckBiometrics - PlatformException: ${e.message}' );
      return false;
    }
  }

  Future<bool> authenticate() async {
    final isAvailable = await checkBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
          localizedReason: authReason, options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true));
    } on PlatformException catch (e) {
      debugPrint('---- authenticate - PlatformException: ${e.message}' );
      return false;
    }
  }
}
