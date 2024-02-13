import 'package:flutter/material.dart';

import '../config/color_constants.dart';

class FloatingSettingsButton extends StatelessWidget {
  const FloatingSettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 65, 0, 0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: white,
          child: const Icon(Icons.settings),
        ),
      ),
    );
  }
}
