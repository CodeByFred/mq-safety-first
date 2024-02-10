import 'package:firebase_auth/firebase_auth.dart';
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
        textButtonTitle: goToLogin,
        showNameField: true,
        nameFieldController: _name,
        showEmailField: true,
        emailFieldController: _email,
        showPasswordField: true,
        passwordFieldController: _password,
        showConfirmPasswordField: true,
        confirmPasswordFieldController: _confirmPassword,
        onPressedLBB: () async {
          final name = _name.text;
          final email = _email.text;
          final password = _password.text;
          final confirmPassword = _confirmPassword.text;

          if (password == confirmPassword && name.isNotEmpty) {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );

            await FirebaseAuth.instance.currentUser?.updateDisplayName(name);

            await FirebaseAuth.instance.currentUser?.sendEmailVerification();

            Navigator.of(context)
                .pushNamedAndRemoveUntil('/verify', (route) => false);
          } else {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(title: Text('Invalid Entry'), actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Go Back'),
                  child: Text('Cancel'),
                )
              ]),
            );
          }

        },
        onPressedATB: () => Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false),
      ),
    );
  }
}
