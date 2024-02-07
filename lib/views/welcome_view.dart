import 'package:flutter/material.dart';

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
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
          child: Column(
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
          ),
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFC6007E)),
                  child: const Text('Register',
                      style: TextStyle(fontSize: 16, fontFamily: 'Montserrat')),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF80225F)),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  ),
                )
              ],
            ),
          )),
    ]));
  }
}
