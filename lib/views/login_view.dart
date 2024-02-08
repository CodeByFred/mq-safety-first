import 'package:flutter/material.dart';
import 'package:mq_safety_first/templates/auth_template.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AuthTemplate(viewTitle: 'Login'));
  }
}
