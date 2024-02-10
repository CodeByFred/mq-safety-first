import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

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
        onPressedLBB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false),
        onPressedATB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/forgotPassword', (route) => false),
      ),
    );
  }
}
