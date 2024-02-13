import 'package:flutter/material.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class HomeViewTileTrailing extends StatelessWidget {
  final IconData leadingIcon;
  final IconData trailingIcon;
  const HomeViewTileTrailing({super.key, required this.leadingIcon, required this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: black,
      child: ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        minVerticalPadding: 20,
        tileColor: white,
        leading: Icon(size: 40, leadingIcon),
        title: Text('Building',
            style: TextStyle(
                fontSize: 15, fontFamily: montserrat)),
        trailing: Icon(trailingIcon, size: 40),
      ),
    );
  }
}
