import 'package:local_auth/local_auth.dart';
import 'package:mpd_client/infrastructure/services/log_service.dart';

mixin BiometricAuth {
  static final LocalAuthentication _auth = LocalAuthentication();
  static bool supportState = false;

  static Future<void> init() async {
    supportState = await _auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      bool authentication = await _auth.authenticate(
        localizedReason: "Autheticate This device !",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
      return authentication;
    } catch (e, s) {
      Log.e("Error Biometric Authentication");
      Log.e(e.toString());
      Log.e(s.toString());
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async => await _auth.getAvailableBiometrics();
}
