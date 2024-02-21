import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';

class HistoryEntryLineText extends StatelessWidget {
  final String text;
  const HistoryEntryLineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(text, style: textStyle15,),
    );
  }
}
