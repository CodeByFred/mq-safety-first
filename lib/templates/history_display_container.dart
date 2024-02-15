import 'package:flutter/material.dart';
import 'package:mq_safety_first/templates/history_entry_line_text.dart';

import '../config/color_constants.dart';

class HistoryDisplayContainer extends StatefulWidget {
  const HistoryDisplayContainer({super.key});

  @override
  State<HistoryDisplayContainer> createState() =>
      _HistoryDisplayContainerState();
}

class _HistoryDisplayContainerState extends State<HistoryDisplayContainer> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
      child: SizedBox(
        height: (height * .2),
        child: Container(
            decoration: const BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(color: black, blurRadius: 4, offset: Offset(0, 1))
              ],
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HistoryEntryLineText(text: 'Date/Time'),
                HistoryEntryLineText(text: 'Activity Name'),
                HistoryEntryLineText(text: 'Lab Type'),
                HistoryEntryLineText(text: 'Building'),
                HistoryEntryLineText(text: 'Buddy Phone'),
                HistoryEntryLineText(text: 'Buddy Email'),
                HistoryEntryLineText(text: 'Duration'),
                HistoryEntryLineText(text: 'Check-in Frequency'),
              ],
            )),
      ),
    );
  }
}
