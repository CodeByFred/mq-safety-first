import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_constants.dart';

class WelcomeButton extends StatelessWidget {
  final Color textColor;
  final Color buttonColor;
  final String buttonText;
  final VoidCallback onPressed;

  const WelcomeButton({
    super.key,
    required this.textColor,
    required this.buttonColor,
    required this.buttonText, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(150, 40),
          foregroundColor: textColor,
          backgroundColor: buttonColor),
      child: Text(buttonText,
          style: const TextStyle(fontSize: 16, fontFamily: montserrat)),
    );
  }
}
