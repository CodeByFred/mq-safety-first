import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

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
        showConfirmPasswordField: false, onPressedLBB: () => Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (route) => false), onPressedATB: () => Navigator.of(context)
          .pushNamedAndRemoveUntil('/welcome', (route) => false),
      ),
    );
  }
}
