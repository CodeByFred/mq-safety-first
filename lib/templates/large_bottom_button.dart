import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class LargeBottomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressedLBB;

  const LargeBottomButton(
      {super.key, required this.buttonTitle, required this.onPressedLBB});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: onPressedLBB,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                fixedSize: const Size(260, 35),
                foregroundColor: white,
                backgroundColor: brightRed),
            child: Text(
              buttonTitle,
              style: const TextStyle(fontSize: 16, fontFamily: montserrat),
            ),
          ),
        ],
      ),
    );
  }
}
