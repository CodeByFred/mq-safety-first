import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_text_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';

import '../config/color_constants.dart';
import '../config/curve_constants.dart';

class AuthTemplate extends StatelessWidget {
  final String viewTitle;

  const AuthTemplate({super.key, required this.viewTitle});

  @override
  Widget build(context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Stack(children: [
      Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              deepRed,
              red,
              brightRed,
              magenta,
              purple,
            ],
            stops: [
              .2,
              .4,
              .6,
              .8,
              1.0,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: CustomPaint(
          painter: CurvePainter(),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
          child: Column(
            children: [
              const MacquarieBanner(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 55.0, 0, 0),
                child: Text(viewTitle,
                    style: const TextStyle(
                      fontFamily: montserrat,
                      fontSize: 28,
                      color: white,
                    )),
              ),
            ],
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LargeBottomButton(buttonTitle: viewTitle),
              const AuthTextButton(buttonTitle: passwordReset),
            ],
          ),
        ),
      ),
    ]);
  }
}


