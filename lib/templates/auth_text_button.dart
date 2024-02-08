import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class AuthTextButton extends StatelessWidget {
  final String buttonTitle;
  const AuthTextButton({super.key, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(
          buttonTitle,
          style: const TextStyle(
            color: brightRed,
            fontSize: 14,
            fontFamily: montserrat,
          ),
        ));
  }
}
