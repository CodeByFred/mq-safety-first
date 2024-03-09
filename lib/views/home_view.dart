import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/home_view_text_input.dart';
import 'package:mq_safety_first/templates/home_view_tile.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/timers/session_timer.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';
import '../config/text_styling_size.dart';
import '../main.dart';
import '../timers/check_in_timer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _userPhone;
  late final TextEditingController _building;
  late final TextEditingController _labType;
  late final TextEditingController _activityName;

  final FocusNode _userPhoneNode = FocusNode();
  final FocusNode _buildingNode = FocusNode();
  final FocusNode _labTypeNode = FocusNode();
  final FocusNode _activityNameNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userPhone = TextEditingController();
    _building = TextEditingController();
    _labType = TextEditingController();
    _activityName = TextEditingController();
    _userPhoneNode.addListener(_userPhoneFocusChange);
    _buildingNode.addListener(_buildingFocusChange);
    _labTypeNode.addListener(_labTypeFocusChange);
    _activityNameNode.addListener(_activityNameFocusChange);
  }

  void _userPhoneFocusChange() {
    if (!_userPhoneNode.hasFocus) {
      // TextField has lost focus, indicating the user has tapped outside or closed the keyboard
      // Store the current value of the TextField into a variable
      setState(() {
        GlobalVariables().userPhone = _userPhone.text;
      });
      print("Stored input: ${GlobalVariables().userPhone}");
    }
  }

  void _buildingFocusChange() {
    if (!_buildingNode.hasFocus) {
      setState(() {
        GlobalVariables().building = _building.text;
      });
      print("Stored input: ${GlobalVariables().building}");
    }
  }

  void _labTypeFocusChange() {
    if (!_labTypeNode.hasFocus) {
      setState(() {
        GlobalVariables().labType = _labType.text;
      });
      print("Stored input: ${GlobalVariables().labType}");
    }
  }

  void _activityNameFocusChange() {
    if (!_activityNameNode.hasFocus) {
      setState(() {
        GlobalVariables().activityName = _activityName.text;
      });
      print("Stored input: ${GlobalVariables().activityName}");
    }
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
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
                  Padding(
                    // WILL THIS WORK FOR EVERY PHONE?
                    padding: const EdgeInsets.fromLTRB(20, 165, 20, 0),
                    child: SizedBox(
                      width: width * .65,
                      height: height / 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(defaultPicPath),
                            maxRadius: 55,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(GlobalVariables().userName,
                                  style: textStyle15Black),
                              GlobalVariables().role != null
                                  ? Text('Role: ${GlobalVariables().role}',
                                      style: textStyle15Black)
                                  : const Text('Role: Not Selected',
                                      style: textStyle15Black),
                            ],
                          )
                        ],
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
                                color: black,
                                blurRadius: 4,
                                offset: Offset(0, 1))
                          ],
                        ),
                        // EDGE INSETS NEEDS FIXING!!! THIS WILL NOT WORK ON EVERY PHONE
                        child: ListView(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            children: <Widget>[
                              HomeViewTile(
                                title: HomeViewTextInput(
                                  controller: _userPhone,
                                  focusNode: _userPhoneNode,
                                  hintText:
                                      GlobalVariables().userPhone.isNotEmpty
                                          ? GlobalVariables().userPhone
                                          : 'User Phone',
                                ),
                                leadingIcon: Icons.call_outlined,
                                onTap: () {},
                              ),
                              HomeViewTile(
                                title: HomeViewTextInput(
                                  controller: _building,
                                  focusNode: _buildingNode,
                                  hintText:
                                      GlobalVariables().building.isNotEmpty
                                          ? GlobalVariables().building
                                          : 'Building',
                                ),
                                leadingIcon: Icons.business_outlined,
                                onTap: () {},
                              ),
                              HomeViewTile(
                                title: HomeViewTextInput(
                                  controller: _labType,
                                  focusNode: _labTypeNode,
                                  hintText: GlobalVariables().labType.isNotEmpty
                                      ? GlobalVariables().labType
                                      : 'Lab Type',
                                ),
                                leadingIcon: Icons.engineering,
                                onTap: () {},
                              ),
                              HomeViewTile(
                                title: HomeViewTextInput(
                                  controller: _activityName,
                                  focusNode: _activityNameNode,
                                  hintText:
                                      GlobalVariables().activityName.isNotEmpty
                                          ? GlobalVariables().activityName
                                          : 'Activity Name',
                                ),
                                leadingIcon: Icons.edit_outlined,
                                onTap: () {},
                              ),
                              HomeViewTile(
                                title: GlobalVariables().checkInDuration != null
                                    ? Text(
                                        'Check-in Frequency: ${GlobalVariables().checkInDuration!.inHours.toString().padLeft(2, '0')}:${(GlobalVariables().checkInDuration!.inMinutes % 60).toString().padLeft(2, '0')}',
                                        style: textStyle15Black,
                                      )
                                    : const Text('Check-in Frequency',
                                        style: textStyle15Black),
                                leadingIcon:
                                    Icons.notifications_active_outlined,
                                onTap: () async {
                                  var resultingDuration =
                                      await showDurationPicker(
                                    context: context,
                                    initialTime: const Duration(minutes: 15),
                                  );
                                  setState(() {
                                    GlobalVariables().checkInDuration =
                                        resultingDuration;
                                  });
                                  CheckInTimerManager.setTimer(GlobalVariables()
                                      .checkInDuration!
                                      .inSeconds);
                                },
                              ),
                              HomeViewTile(
                                leadingIcon: Icons.update_outlined,
                                title: GlobalVariables().sessionDuration != null
                                    ? Text(
                                        'Session Length: ${GlobalVariables().sessionDuration!.inHours.toString().padLeft(2, '0')}:${(GlobalVariables().sessionDuration!.inMinutes % 60).toString().padLeft(2, '0')}',
                                        style: textStyle15Black,
                                      )
                                    : const Text('Change Session Length',
                                        style: textStyle15Black),
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

                                    setState(() {
                                      GlobalVariables().sessionDuration =
                                          futureDateTime.difference(now);
                                    });

                                    SessionTimerManager.setTimer(
                                        GlobalVariables()
                                            .sessionDuration!
                                            .inSeconds);
                                  }
                                },
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 50,
                right: 0,
                left: 0,
                child: LargeBottomButton(
                  buttonTitle: startSession,
                  onPressedLBB: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/activeSession', (route) => false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
