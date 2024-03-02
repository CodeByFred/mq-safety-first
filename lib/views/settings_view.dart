import 'package:duration_picker/duration_picker.dart';
import 'package:flic_button/flic_button.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/flic2/flic_methods.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/color_constants.dart';
import '../config/image_constants.dart';
import '../config/text_constants.dart';
import '../timers/check_in_timer.dart';
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
  final Duration _duration = const Duration(hours: 0, minutes: 0);

  bool _selectedBluetooth = false;
  String? _selectedValueDropDownRole;
  bool _isSelectedSound = false;
  bool _isSelectedVibrate = false;
  bool _isSelectedCampusSecurity = false;

  IconData? get leadingIcon => null;

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
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              // minVerticalPadding: 20,
                              tileColor: white,
                              title:
                                  const Text('Role', style: textStyle15Black),
                              trailing: DropdownButton<String>(
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedValueDropDownRole = newValue;
                                  });
                                },
                                hint: const Text('Select Role',
                                    style: textStyle15Black),
                                value: _selectedValueDropDownRole,
                                items: [
                                  'Undergraduate',
                                  'Postgraduate',
                                  'Employee'
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
                                dense: true,
                                tileColor: white,
                                trailing: Icon(Icons.phone),
                                title: Text('Buddy Phone',
                                    style: textStyle15Black)),
                          ),
                          const Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                trailing: Icon(Icons.email),
                                title: Text('Buddy Email',
                                    style: textStyle15Black)),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: const Text('Notify Campus Security',
                                    style: textStyle15Black),
                                trailing: Switch(
                                  inactiveThumbColor: black,
                                  inactiveTrackColor: white,
                                  thumbIcon: thumbIcon,
                                  value: _isSelectedCampusSecurity,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isSelectedCampusSecurity = value;
                                    });
                                  },
                                )),
                          ),
                          Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: const Text('Check-in Frequency',
                                    style: textStyle15Black),
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
                                                    int temp =
                                                        val.inMinutes % 60;
                                                    Duration tempDuration =
                                                        Duration(minutes: temp);
                                                    localDuration =
                                                        tempDuration;
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
                                              snapToMins: 5,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              )),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: const Text('Change Session Length',
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
                                    final durationInSeconds = futureDateTime
                                        .difference(now)
                                        .inSeconds;

                                    // Send this duration to your CountdownTimerManager
                                    SessionTimerManager.setTimer(
                                        durationInSeconds);
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
                                trailing: const Icon(Icons.chevron_right)),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              tileColor: white,
                              title: const Text('Pair Bluetooth Button',
                                  style: textStyle15Black),
                              trailing: Icon(
                                Icons.bluetooth,
                                color: Colors.blue,
                              ),
                              // (buttonsFound != null) ? Colors.blue : null),
                              onTap: () async {
                                // handleTap();

                                // setState(() {
                                //   buttonsFound;
                                // });

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
                                    const Text('Sound',
                                        style: textStyle15Black),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Switch(
                                        inactiveThumbColor: black,
                                        inactiveTrackColor: white,
                                        thumbIcon: thumbIcon,
                                        value: _isSelectedSound,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _isSelectedSound = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Vibrate',
                                        style: textStyle15Black),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Switch(
                                        inactiveThumbColor: black,
                                        inactiveTrackColor: white,
                                        thumbIcon: thumbIcon,
                                        value: _isSelectedVibrate,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _isSelectedVibrate = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
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
                                trailing: const Icon(Icons.flag)),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
        LargeBottomButton(
            buttonTitle: logOut,
            onPressedLBB: () => Navigator.pushNamedAndRemoveUntil(
                context, '/welcome', (route) => false))
      ]),
    );
  }
}
