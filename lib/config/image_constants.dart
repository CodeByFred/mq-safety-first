import 'package:flutter/material.dart';

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
              'assets/images/mq_welcome_screen.png',
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
          width: 200.0,
          child: ColoredBox(
            color: Colors.white,
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Safety First",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


