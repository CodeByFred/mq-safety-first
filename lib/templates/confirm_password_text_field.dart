import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const ConfirmPasswordTextField({
    super.key,
    required this.controller,
  });

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
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
            hintText: confirmPassword,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: brightRed)),
            border: UnderlineInputBorder(),
            prefixIcon: IconButton(
              onPressed: null,
              disabledColor: brightRed,
              icon: Icon(Icons.lock),
            )));
  }
}
