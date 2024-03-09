import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class LargeBottomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onPressedLBB;

  const LargeBottomButton(
      {super.key, required this.buttonTitle, required this.onPressedLBB});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: textStyle16White,
          ),
        ),
      ],
    );
  }
}
