import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';

import '../config/image_constants.dart';
import '../config/text_constants.dart';
import '../config/text_styling_size.dart';

class ReportIssueView extends StatefulWidget {
  const ReportIssueView({super.key});

  @override
  State<ReportIssueView> createState() => _ReportIssueViewState();
}

class _ReportIssueViewState extends State<ReportIssueView> {
  String? _selectValueDropDownIssue;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(width: width, height: height,
          child: Stack(children: [
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
              padding: const EdgeInsets.only(
                top: 155,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Container(height: height *.53,
                      decoration: const BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black, blurRadius: 4, offset: Offset(0, 1))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 5),
          
                        child: Column(
                            children: <Widget>[
                              Card(
                                elevation: 10,
                                shadowColor: black,
                                child: ListTile(
                                  dense: true,
                                  // minVerticalPadding: 20,
                                  tileColor: white,
                                  title: const Text('Issue', style: textStyle15Black),
                                  trailing: DropdownButton<String>(
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectValueDropDownIssue = newValue;
                                      });
                                    },
                                    hint: const Text('Select one',
                                        style: textStyle15Black),
                                    value: _selectValueDropDownIssue,
                                    items: [
                                      'Accident',
                                      'Near Miss',
                                      'Issue with App',
                                      'Other',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value, style: textStyle15Black),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const Card(
                                elevation: 10,
                                shadowColor: black,
                                child: ListTile(
                                    tileColor: Colors.white,
                                    title: TextField(
                                      minLines: 5,
                                      maxLines: 5,
                                      style: textStyle15Black,
                                      decoration: InputDecoration(
                                          hintText: 'Issue Description',
                                          border: UnderlineInputBorder(
                                              borderSide: BorderSide.none)),
                                    )),
                              ), const Padding(
                                padding: EdgeInsets.only(top: 75),
                                child: Column(
                                  children: [
                                    Icon(Icons.add_a_photo_outlined, size: 50), Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Add Photo (Optional)', style: textStyle15Black,),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
            Positioned(bottom: 40, left: 0, right: 0,
              child: LargeBottomButton(
                buttonTitle: submit,
                onPressedLBB: () => Navigator.pop(context),
              ),
            ), ]),
        ),
      ),
    );
  }
}
