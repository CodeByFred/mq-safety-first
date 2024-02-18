import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

import '../config/color_constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthTemplate(
        viewTitle: login,
        buttonTitle: login,
        textButtonTitle: forgotPassword,
        showNameField: false,
        showEmailField: true,
        emailFieldController: _email,
        showPasswordField: true,
        passwordFieldController: _password,
        showConfirmPasswordField: false,
        onPressedLBB: () async {
          final email = _email.text;
          final password = _password.text;
          // final bool verified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;
          // print(verified);
          // if (verified) {
            final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
            print(userCredential);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          // } else {
          //   print('Failed');
          //   showDialog(
          //       context: context,
          //       builder: (context) => AlertDialog(backgroundColor: white, surfaceTintColor: white,
          //             title: const Text('Invalid Credentials'),
          //             actions: <Widget>[
          //               TextButton(
          //                   onPressed: () => Navigator.pop(context, 'Cancel'),
          //                   child: const Text('Cancel'))
          //             ],
          //           ));
          // }
        },
        onPressedATB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/forgotPassword', (route) => false),
      ),
    );
  }
}
