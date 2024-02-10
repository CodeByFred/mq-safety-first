import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/templates/welcome_button.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        width: double.infinity,
        // Ensures the container fills the width
        height: double.infinity,
        // Ensures the container fills the height
        child: Image.asset(
          'assets/images/welcome.jpg',
          fit: BoxFit
              .cover, // This will cover the whole screen, maintaining aspect ratio
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 80.0, 0, 0),
          child: MacquarieBanner(),
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              // do i need this?
              mainAxisSize: MainAxisSize.min,
              children: [
                WelcomeButton(
                    textColor: white,
                    buttonColor: magenta,
                    buttonText: register,
                    onPressed: () =>
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/register',
                          (route) => false,
                        )),
                const SizedBox(height: 20),
                WelcomeButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false),
                  textColor: white,
                  buttonColor: purple,
                  buttonText: login,
                )
              ],
            ),
          )),
    ]));
  }
}
