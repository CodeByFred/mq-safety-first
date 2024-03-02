import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class HomeScreenTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Function onTap;
  const HomeScreenTile({super.key, required this.leadingIcon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: black,
      child: ListTile(
        minVerticalPadding: 20,
        tileColor: white,
        leading: Icon(size: 40, leadingIcon),
        title: Text(title,
            style: textStyle15Black),
        onTap: () =>  onTap,
      ),
    );
  }
}
