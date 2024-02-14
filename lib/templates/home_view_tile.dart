import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_15.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class HomeScreenTile extends StatelessWidget {
  final IconData leadingIcon;
  const HomeScreenTile({super.key, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: black,
      child: ListTile(
        minVerticalPadding: 20,
        tileColor: white,
        leading: Icon(size: 40, leadingIcon),
        title: const Text('Building',
            style: textStyle15),
      ),
    );
  }
}
