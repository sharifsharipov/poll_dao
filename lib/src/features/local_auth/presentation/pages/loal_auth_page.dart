import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:poll_dao/src/features/discover_page/presentation/pages/dicover_page.dart';
class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({super.key});

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

enum SupportState { unknown, supported, unsupported }

class _LocalAuthPageState extends State<LocalAuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;
  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        supportState = isSupported ? SupportState.supported : SupportState.unsupported;
      });
    });
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;

      debugPrint("Biometric supported:$canCheckBiometric");
    } on PlatformException catch (e) {
      debugPrint("Biometric not supported:$e");
      canCheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricsType;
    try {
      biometricsType = await auth.getAvailableBiometrics();
      debugPrint("Biometric supported:$biometricsType");
    } on PlatformException catch (e) {
    debugPrint("Biometric not supported:$e");
    }
    if (!mounted) return;

    setState(() {
      availableBiometrics = biometricsType;
    });
  }

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint or face ID',
          options: const AuthenticationOptions(stickyAuth: true, biometricOnly: true));
      if (!mounted) return;
      if (authenticated) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DisCoverPage()));
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric Authentication"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              supportState == SupportState.supported
                  ? "Biometric authentication is supported on the divice"
                  : supportState == SupportState.unsupported
                  ? "Biometric authentication is not supported on the divice"
                  : "Checking biometric support....",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: supportState == SupportState.supported
                    ? Colors.green
                    : supportState == SupportState.unsupported
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text("Supported Biometrics: $availableBiometrics"),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.face),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: authenticateWithBiometrics,
                  child: const Text("Authenticate"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
