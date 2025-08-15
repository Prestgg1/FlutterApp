import 'package:flutter/material.dart';
import 'package:safatapp/services/auth/google_auth.dart';

class GoogleLoginBtn extends StatefulWidget {
  const GoogleLoginBtn({super.key});

  @override
  State<GoogleLoginBtn> createState() => _GoogleLoginBtnState();
}

class _GoogleLoginBtnState extends State<GoogleLoginBtn> {
  String? status;

  Future<void> _loginWithGoogle() async {
    try {
      if (signIn.supportsAuthenticate()) {
        final user = await signIn.authenticate();
        debugPrint(user.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () {
          _loginWithGoogle();
        },
        icon: Image.asset("assets/Google.png", height: 24),
        label: Text(
          "Google ile daxil olun",
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
