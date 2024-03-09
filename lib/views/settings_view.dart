import 'package:duration_picker/duration_picker.dart';
import 'package:flic_button/flic_button.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';
import 'package:mq_safety_first/main.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/flic2/flic_methods.dart';
import 'package:mq_safety_first/timers/check_in_timer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/color_constants.dart';
import '../config/image_constants.dart';
import '../config/text_constants.dart';
import '../timers/session_timer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

final MaterialStateProperty<Icon?> thumbIcon =
    MaterialStateProperty.resolveWith<Icon?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  },
);

class _SettingsViewState extends State<SettingsView> {
  late final TextEditingController _buddyPhone;
  late final TextEditingController _buddyEmail;
  final FocusNode _buddyPhoneFocusNode = FocusNode();
  final FocusNode _buddyEmailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _buddyPhone = TextEditingController();
    _buddyEmail = TextEditingController();
    _buddyPhoneFocusNode.addListener(_onBuddyPhoneFocusChange);
    _buddyEmailFocusNode.addListener(_onBuddyEmailFocusChange);
  }

  void _onBuddyPhoneFocusChange() {
    if (!_buddyPhoneFocusNode.hasFocus) {
      // TextField has lost focus, indicating the user has tapped outside or closed the keyboard
      // Store the current value of the TextField into a variable
      setState(() {
        GlobalVariables().buddyPhone = _buddyPhone.text;
      });
      print("Stored input: ${GlobalVariables().buddyPhone}");
    }
  }

  void _onBuddyEmailFocusChange() {
    if (!_buddyEmailFocusNode.hasFocus) {
      // TextField has lost focus, indicating the user has tapped outside or closed the keyboard
      // Store the current value of the TextField into a variable
      setState(() {
        GlobalVariables().buddyEmail = _buddyEmail.text;
      });
      print("Stored input: ${GlobalVariables().buddyEmail}");
    }
  }

  void handleTap() async {
    bool isGranted = await Permission.bluetooth.request().isGranted &&
        await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted &&
        await Permission.location.request().isGranted;

    if (isGranted) {
      // Assuming GlobalVariables.flicPlugin is statically accessible
      final flicPlugin = FlicButtonPlugin(flic2listener: ButtonListener());

      flicPlugin.invokation?.then((value) {
        // Initialization logic here
        return flicPlugin.getFlic2Buttons();
      }).then((value) async {
        if (value.isEmpty) {
          // No buttons found, start scanning
          bool? found = await flicPlugin.scanForFlic2();
          print('Scanning');
          print(found);
        }
      });
    } else {
      // Handle the case where permissions are not granted
      print("Permissions not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // Prevents Scaffold from resizing when the keyboard appears

      body: Stack(children: [
        FloatingTopLeftButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pop(context),
        ),
        const Positioned(
            top: 60,
            right: 25,
            child: CircleAvatar(
              backgroundImage: AssetImage(defaultPicPath),
              maxRadius: 55,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 155),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: SizedBox(
                  height: height * .67,
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
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              tileColor: white,
                              leading: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.badge_outlined),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 85),
                                child: DropdownButton<String>(
                                  onChanged: (newValue) {
                                    setState(() {
                                      GlobalVariables().role = newValue;
                                    });
                                  },
                                  // isExpanded: true,
                                  hint: const Text('Select Role',
                                      style: textStyle15Black),
                                  value: GlobalVariables().role,
                                  items: [
                                    'Undergraduate',
                                    'Postgraduate',
                                    'Employee'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child:
                                          Text(value, style: textStyle15Black),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                leading: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.contact_phone_outlined),
                                ),
                                trailing: SizedBox(
                                  width: 230,
                                  // alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: _buddyPhone,
                                    focusNode: _buddyPhoneFocusNode,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.number,
                                    // textAlign: TextAlign.right,
                                    style: textStyle15Black,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintText: GlobalVariables()
                                                .buddyPhone
                                                .isNotEmpty
                                            ? GlobalVariables().buddyPhone
                                            : 'Buddy Phone',
                                        border: InputBorder.none,
                                        hintStyle: textStyle15Black),
                                  ),
                                )),
                          ),
                          Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                dense: true,
                                tileColor: white,
                                leading: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.contact_mail_outlined),
                                ),
                                trailing: SizedBox(
                                  width: 230,
                                  // alignment: Alignment.centerRight,
                                  child: TextField(
                                    controller: _buddyEmail,
                                    focusNode: _buddyEmailFocusNode,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // textAlign: TextAlign.right,
                                    style: textStyle15Black,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintText: GlobalVariables()
                                                .buddyEmail
                                                .isNotEmpty
                                            ? GlobalVariables().buddyEmail
                                            : 'Buddy Email',
                                        border: InputBorder.none,
                                        hintStyle: textStyle15Black),
                                  ),
                                ),
                              )),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: Transform.translate(
                                  offset: const Offset(-25, 0),
                                  child: const Text('Notify Campus Security',
                                      style: textStyle15Black),
                                ),
                                leading: Transform.translate(
                                  offset: const Offset(-15, 0),
                                  child: Switch(
                                    inactiveThumbColor: black,
                                    inactiveTrackColor: white,
                                    thumbIcon: thumbIcon,
                                    value: GlobalVariables()
                                        .isSelectedCampusSecurity,
                                    onChanged: (bool value) {
                                      setState(() {
                                        GlobalVariables()
                                            .isSelectedCampusSecurity = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                  dense: true,
                                  tileColor: white,
                                  leading: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                        Icons.notifications_active_outlined),
                                  ),
                                  title:
                                      GlobalVariables().checkInDuration != null
                                          ? Text(
                                              'Check-in Frequency: ${GlobalVariables().checkInDuration!.inHours.toString().padLeft(2, '0')}:${(GlobalVariables().checkInDuration!.inMinutes % 60).toString().padLeft(2, '0')}',
                                              style: textStyle15Black,
                                            )
                                          : const Text('Check-in Frequency',
                                              style: textStyle15Black),
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
                                    CheckInTimerManager.setTimer(
                                        GlobalVariables()
                                            .checkInDuration!
                                            .inSeconds);
                                  })),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                leading: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.update,
                                  ),
                                ),
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
                                }),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/history'),
                              dense: true,
                              tileColor: white,
                              title: const Text('View History',
                                  style: textStyle15Black),
                              leading: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(Icons.search),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              tileColor: white,
                              title: const Text('Pair Bluetooth Button',
                                  style: textStyle15Black),
                              leading: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.bluetooth,
                                  color: GlobalVariables().selectedBluetooth
                                      ? Colors.blue
                                      : black,
                                ),
                              ),
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => const Dialog(
                                    child: MyAppFlic(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                dense: true,
                                tileColor: white,
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(-15, 0),
                                      child: Switch(
                                        inactiveThumbColor: black,
                                        inactiveTrackColor: white,
                                        thumbIcon: thumbIcon,
                                        value:
                                            GlobalVariables().isSelectedSound,
                                        onChanged: (bool value) {
                                          setState(() {
                                            GlobalVariables().isSelectedSound =
                                                value;
                                          });
                                        },
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(-10, 0),
                                      child: const Text('Sound',
                                          style: textStyle15Black),
                                    ),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Switch(
                                        inactiveThumbColor: black,
                                        inactiveTrackColor: white,
                                        thumbIcon: thumbIcon,
                                        value:
                                            GlobalVariables().isSelectedVibrate,
                                        onChanged: (bool value) {
                                          setState(() {
                                            GlobalVariables()
                                                .notifyCampusSecurity = value;
                                            GlobalVariables()
                                                .isSelectedVibrate = value;
                                          });
                                        },
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text('Vibrate',
                                            style: textStyle15Black),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/report'),
                                dense: true,
                                tileColor: white,
                                title: const Text('Report Issue',
                                    style: textStyle15Black),
                                leading: const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.flag_outlined),
                                )),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: LargeBottomButton(
            buttonTitle: logOut,
            onPressedLBB: () => Navigator.pushNamedAndRemoveUntil(
                context, '/welcome', (route) => false),
          ),
        )
      ]),
    );
  }
}
