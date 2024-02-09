import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          color: black,
          fontSize: 14,
          fontFamily: montserrat,
        ),
        decoration: const InputDecoration(
            hintText: password,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: brightRed)),
            border: UnderlineInputBorder(),
            prefixIcon: IconButton(
              onPressed: null,
              disabledColor: brightRed,
              icon: Icon(Icons.lock),
            )));
  }
}
