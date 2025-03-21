import 'package:flutter/material.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/history_display_container.dart';

import '../config/image_constants.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: Stack(children: <Widget>[
        FloatingTopLeftButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        PositionedDirectional(
          // WILL THIS WORK FOR EVERY PHONE?
          start: (width / 2),
          child: const Padding(
            // WILL THIS WORK FOR EVERY PHONE?
              padding: EdgeInsets.fromLTRB(0, 65, 25, 0),
              child: Column(
                children: [
                  MacquarieBanner(),
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 110),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: ListView(children: const <Widget>[
                HistoryDisplayContainer(),
                HistoryDisplayContainer(),
                HistoryDisplayContainer(),
                HistoryDisplayContainer(),
                HistoryDisplayContainer(),
              ]),
            ),
          ),
        )
      ]),
    );
  }
}
