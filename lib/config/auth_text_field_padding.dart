import 'package:flutter/material.dart';

class AuthTextFieldPadding extends StatelessWidget {
  final Widget? child;
  const AuthTextFieldPadding({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0), child: child,);

  }
}
