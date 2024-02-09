import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;

  const EmailTextField({
    super.key,
    required this.controller,
  });

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
        color: black,
        fontSize: 14,
        fontFamily: montserrat,
      ),
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          hintText: email,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: brightRed)),
          border: UnderlineInputBorder(),
          prefixIcon: IconButton(
            onPressed: null,
            disabledColor: brightRed,
            icon: Icon(Icons.email),
          )),
    );
  }
}
