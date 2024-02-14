import 'package:flutter/material.dart';

import '../config/color_constants.dart';

class FloatingTopLeftButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const FloatingTopLeftButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 65, 0, 0),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: white,
          child: Icon(icon),
        ),
      ),
    );
  }
}
