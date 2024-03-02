import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/home_view_tile.dart';
import 'package:mq_safety_first/templates/home_view_tile_trailing.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/timers/session_timer.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';
import '../timers/check_in_timer.dart';

Future<TimeOfDay?>? selectedTime;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Duration _duration = const Duration(hours: 0, minutes: 0);
  late final TextEditingController _building;

  @override
  void initState() {
    _building = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _building.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: white,
      // Using a stack to place items where I need to without affecting the placement of other widgets
      body: Stack(
        children: [
          FloatingTopLeftButton(
              icon: Icons.settings,
              onPressed: () => Navigator.pushNamed(context, '/settings')),
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
          Column(
            children: [
              Flexible(
                child: Padding(
                  // WILL THIS WORK FOR EVERY PHONE?
                  padding: const EdgeInsets.fromLTRB(20, 165, 20, 0),
                  child: SizedBox(
                    width: width * .65,
                    height: height / 8,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(defaultPicPath),
                          maxRadius: 55,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Hello Frederick',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: montserrat)),
                            Text('Role: Student',
                                style: TextStyle(
                                    fontSize: 15, fontFamily: montserrat)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 5),
                child: SizedBox(
                  height: height * .5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                            color: black, blurRadius: 4, offset: Offset(0, 1))
                      ],
                    ),
                    // EDGE INSETS NEEDS FIXING!!! THIS WILL NOT WORK ON EVERY PHONE
                    child: ListView(
                        padding: const EdgeInsets.fromLTRB(20, 35, 20, 10),
                        children: <Widget>[
                          HomeScreenTile(
                            title: 'Building',
                            leadingIcon: Icons.business,
                            onTap: () {},
                          ),
                          HomeScreenTile(
                            title: 'Lab Type',
                            leadingIcon: Icons.engineering,
                            onTap: () {},
                          ),
                          HomeScreenTile(
                            title: 'Activity Name',
                            leadingIcon: Icons.edit,
                            onTap: () {},
                          ),
                          HomeViewTileTrailing(
                            title: 'Check-in Frequency',
                            leadingIcon: Icons.notifications_active,
                            trailingIcon: Icons.chevron_right,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  // Use dialogContext to differentiate it from the widget tree context
                                  Duration localDuration =
                                      _duration; // Make a local copy of _duration to use within the dialog
                                  return Dialog(
                                    child: StatefulBuilder(
                                      // Introduce StatefulBuilder here
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        // This setState is local to the StatefulBuilder's scope
                                        return DurationPicker(
                                          height: 500,
                                          width: 500,
                                          duration: localDuration,
                                          // Use localDuration inside the dialog
                                          onChange: (val) {
                                            setState(() {
                                              // Check if the total minutes exceed 60
                                              if (val.inMinutes > 60) {
                                                // If it exceeds 60 minutes, calculate the remainder of minutes after dividing by 60
                                                int temp = val.inMinutes % 60;
                                                Duration tempDuration =
                                                    Duration(minutes: temp);
                                                localDuration = tempDuration;
                                              } else {
                                                localDuration = val;
                                              }
                                            });

                                            // Convert the selected/adjusted duration to seconds
                                            int durationInSeconds =
                                                localDuration.inSeconds;

                                            // Pass the seconds to the CountdownTimerManager
                                            CheckInTimerManager.setTimer(
                                                durationInSeconds);

                                            // If you want to update the main state _duration when dialog is still open, do it here as well
                                            // Note: This will not re-render the main widget until the dialog is closed
                                          },
                                          // snapToMins: 5,
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          HomeViewTileTrailing(
                            title: 'Session Length',
                            leadingIcon: Icons.update,
                            trailingIcon: Icons.chevron_right,
                            onTap: () async {
                              final now = DateTime.now();
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                final todayPickedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    pickedTime.hour,
                                    pickedTime.minute);
                                final futureDateTime =
                                    todayPickedDateTime.isBefore(now)
                                        ? todayPickedDateTime
                                            .add(const Duration(days: 1))
                                        : todayPickedDateTime;
                                final durationInSeconds =
                                    futureDateTime.difference(now).inSeconds;

                                // Send this duration to your CountdownTimerManager
                                SessionTimerManager.setTimer(durationInSeconds);
                              }
                            },
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          // SHOULD I MAKE THIS A TEMPLATE SINCE IT IS ON MULTIPLE SCREENS? NOT SURE IF IT'S POSSIBLE
          LargeBottomButton(
            buttonTitle: startSession,
            onPressedLBB: () => Navigator.pushNamedAndRemoveUntil(
                context, '/activeSession', (route) => false),
          ),
        ],
      ),
    );
  }
}
