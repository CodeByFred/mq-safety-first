import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

import '../config/color_constants.dart';

class HomeViewTile extends StatelessWidget {
  final IconData leadingIcon;
  final Widget title;
  final VoidCallback onTap;
  const HomeViewTile({super.key, required this.leadingIcon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: black,
      child: ListTile(
        tileColor: white,
        leading: Icon(size: 40, leadingIcon),
        title: title,
        onTap: onTap,
      ),
    );
  }
}
