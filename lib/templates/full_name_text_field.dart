import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class FullNameTextField extends StatefulWidget {
  final TextEditingController controller;

  const FullNameTextField({
    super.key,
    required this.controller,
  });

  @override
  State<FullNameTextField> createState() => _FullNameTextFieldState();
}

class _FullNameTextFieldState extends State<FullNameTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      // ADD COMMENT
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
        color: black,
        fontSize: 14,
        fontFamily: montserrat,
      ),
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
          hintText: fullName,
          enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: brightRed)),
          border: UnderlineInputBorder(),
          prefixIcon: IconButton(
            onPressed: null,
            disabledColor: brightRed,
            icon: Icon(Icons.person),
          )),
    );
  }
}