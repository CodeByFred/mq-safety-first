import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';

import '../config/text_constants.dart';

class VerifyText extends StatelessWidget {
  const VerifyText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
      child: Center(
          child: Column(
        children: [
          Text(
              verifyText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontFamily: montserrat, color: black)),
        ],
      )),
    );
  }
}
