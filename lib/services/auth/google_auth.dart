import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

const webClientId =
    '46538463113-aeq4dfereklcvm3o5k0vs3vfoc66aumm.apps.googleusercontent.com';
const iosClientId =
    '46538463113-aeq4dfereklcvm3o5k0vs3vfoc66aumm.apps.googleusercontent.com';

final GoogleSignIn signIn = GoogleSignIn.instance;

Future<void> initGoogle() async {
  unawaited(
    signIn
        .initialize(
          clientId: defaultTargetPlatform == TargetPlatform.iOS
              ? iosClientId
              : null,
          serverClientId: webClientId,
        )
        .then((_) {
          signIn.authenticationEvents.listen(
            (e) => debugPrint('Auth event: $e'),
            onError: (err) => debugPrint('Auth stream error: $err'),
          );
          signIn.attemptLightweightAuthentication();
        }),
  );
}
