import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
  static Future<bool> authenticate() async {
    try {
      if (!await hasBiometrics()) {
        return false;
      }
      return await _auth.authenticate(
        authMessages: const [
          /*  AndroidAuthMessages(
            signInTitle: "Authenticate to access the app",
            cancelButton: "Cancel",
          ),
          IOSAuthMessages(
            cancelButton: "not ",
          )
*/
        ],
        localizedReason: "Authenticate to access the app",
      );
    } catch (e) {
      debugPrint("Error during authentication: $e");
      return false;
    }
  }

}

