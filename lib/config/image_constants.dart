import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

const mqWelcomeScreenPath = 'assets/images/mq_welcome_screen.png';
const defaultPicPath = 'assets/images/default.jpg';
const welcomePath = 'assets/images/welcome.jpg';

class MacquarieBanner extends StatelessWidget {
  const MacquarieBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRect(
          child: Align(
            heightFactor: 0.9,
            child: Image.asset(
              mqWelcomeScreenPath,
            ),
          ),
        ),
        const SizedBox(
          height: 25.0,
          width: 200.0,
          child: ColoredBox(
            color: white,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                safetyFirst,
                textAlign: TextAlign.center,
                style: textStyle15Black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
