import 'package:flutter/material.dart';

import '../config/text_styling_size.dart';

class HomeViewTextInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;

  const HomeViewTextInput(
      {super.key,
      required this.controller,
      required this.focusNode,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 215,
      child: TextField(
          controller: controller,
          focusNode: focusNode,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.text,
          style: textStyle15Black,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: textStyle15Black,
          )),
    );
  }
}
