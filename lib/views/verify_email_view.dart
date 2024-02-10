import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

import '../config/text_constants.dart';
import '../firebase_options.dart';

class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          return AuthTemplate(
            viewTitle: verifyEmail,
            buttonTitle: resendVerification,
            textButtonTitle: proceedToLogin,
            showVerifyTextWidget: true,
            showNameField: false,
            showEmailField: false,
            showPasswordField: false,
            showConfirmPasswordField: false,
            onPressedATB: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/login', (route) => false),
            onPressedLBB: () async {
              await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            },
          );
        },
      ),
    );
  }
}
