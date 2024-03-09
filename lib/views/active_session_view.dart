import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';
import 'package:mq_safety_first/main.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/timers/check_in_timer.dart';
import 'package:mq_safety_first/timers/session_timer.dart';

class ActiveSessionView extends StatefulWidget {
  const ActiveSessionView({super.key});

  @override
  State<ActiveSessionView> createState() => _ActiveSessionViewState();
}

class _ActiveSessionViewState extends State<ActiveSessionView> {
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: Stack(children: [
        FloatingTopLeftButton(
          icon: Icons.settings,
          onPressed: () => Navigator.pushNamed(context, '/settings'),
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
          padding: const EdgeInsets.only(top: 165),
          child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 125,
                    width: (width * .8),
                    decoration: const BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black, blurRadius: 4, offset: Offset(0, 1))
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Building: ',
                                    style: textStyle20Black,
                                  ),
                                  TextSpan(
                                    text: GlobalVariables().building, // Your formatted time here
                                    style: textStyle20Green, // Specific style for the time
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Lab Type: ',
                                    style: textStyle20Black,
                                  ),
                                  TextSpan(
                                    text: GlobalVariables().labType, // Your formatted time here
                                    style: textStyle20Green, // Specific style for the time
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Activity Name: ',
                                    style: textStyle20Black,
                                  ),
                                  TextSpan(
                                    text: GlobalVariables().activityName, // Your formatted time here
                                    style: textStyle20Green, // Specific style for the time
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: SessionTimer(),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                        onPressed: () {
                          null;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: brightRed,
                            foregroundColor: white,
                            fixedSize: Size((width * .8), 250),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Alarm',
                          style: textStyle20White,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      height: 75,
                      width: (width * .8),
                      decoration: const BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black, blurRadius: 4, offset: Offset(0, 1))
                        ],
                      ),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Check In Time Left:',
                              style: textStyle20Black,
                            ),
                            CheckInTimer(),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                null;
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  foregroundColor: white,
                                  backgroundColor: Colors.orange,
                                  fixedSize: Size((width * .375), 100)),
                              child: const Text('End Session',
                                  style: textStyle20White,
                                  maxLines: 2,
                                  textAlign: TextAlign.center)),
                          ElevatedButton(
                            onPressed: () {

                              if(CheckInTimerManager.secondsRemaining < 60) {
                                CheckInTimerManager.setTimer(CheckInTimerManager.lastSelectedTime);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: white,
                                backgroundColor: Colors.green,
                                fixedSize: Size((width * .375), 100)),
                            child: const Text('Check In', style: textStyle20White),
                          ),
                        ]),
                  )
                ],
              )),
        )
      ]),
    );
  }
}
