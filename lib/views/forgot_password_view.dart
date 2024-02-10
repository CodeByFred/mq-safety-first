import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

import '../firebase_options.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthTemplate(
          viewTitle: forgotPassword,
          buttonTitle: passwordReset,
          textButtonTitle: cancel,
          showNameField: false,
          showEmailField: true,
          emailFieldController: _email,
          showPasswordField: false,
          showConfirmPasswordField: false,
          onPressedLBB: () async {
            final email = _email.text;
            final bool verified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
            if(!verified) {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
            } else {
              AlertDialog(title: Text('Account Already Verified'),actions: <Widget> [TextButton(onPressed: () => Navigator.pop(context, 'Cancel'), child: Text('Cancel'))],);
            }
          },
          onPressedATB: () {
            print(FirebaseAuth.instance.currentUser);

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/welcome', (route) => false);
          }),
    );
  }
}
