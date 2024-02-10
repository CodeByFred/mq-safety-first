import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthTemplate(
        viewTitle: register,
        buttonTitle: register,
        textButtonTitle: returnToLogin,
        showNameField: true,
        nameFieldController: _name,
        showEmailField: true,
        emailFieldController: _email,
        showPasswordField: true,
        passwordFieldController: _password,
        showConfirmPasswordField: true,
        confirmPasswordFieldController: _confirmPassword,
        onPressedLBB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false),
        onPressedATB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false),
      ),
    );
  }
}
