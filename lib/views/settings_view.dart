import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_15.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';

import '../config/color_constants.dart';
import '../config/image_constants.dart';
import '../config/text_constants.dart';

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
  String? _selectedValueDropDownRole;
  bool _isSelectedSound = false;
  bool _isSelectedVibrate = false;
  bool _isSelectedCampusSecurity = false;

  IconData? get leadingIcon => null;

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: Stack(children: [
        FloatingTopLeftButton(
          icon: Icons.arrow_back,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false),
        ),
        const Positioned(
            top: 60,
            right: 25,
            child: CircleAvatar(
              backgroundImage: AssetImage(defaultPicPath),
              maxRadius: 60,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 175),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                  height: height * .62,
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
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              // minVerticalPadding: 20,
                              tileColor: white,
                              title: const Text('Role', style: textStyle15),
                              trailing: DropdownButton<String>(
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedValueDropDownRole = newValue;
                                  });
                                },
                                hint: const Text('Select Role',
                                    style: textStyle15),
                                value: _selectedValueDropDownRole,
                                items: [
                                  'Undergraduate',
                                  'Postgraduate',
                                  'Employee'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: textStyle15),
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
                                title: Text('Buddy Phone', style: textStyle15)),
                          ),
                          const Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                trailing: Icon(Icons.email),
                                title: Text('Buddy Email', style: textStyle15)),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: const Text('Notify Campus Security',
                                    style: textStyle15),
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
                          const Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: Text('Check-in Frequency',
                                    style: textStyle15)),
                          ),
                          const Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: Text('Duration', style: textStyle15)),
                          ),
                          const Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: Text('View History', style: textStyle15),
                                trailing: Icon(Icons.chevron_right)),
                          ),
                          const Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                dense: true,
                                tileColor: white,
                                title: Text('Pair Bluetooth Button',
                                    style: textStyle15),
                                trailing: Icon(Icons.bluetooth),
                              )),
                          Card(
                              elevation: 10,
                              shadowColor: black,
                              child: ListTile(
                                dense: true,
                                tileColor: white,
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Sound', style: textStyle15),
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
                                    const Text('Vibrate', style: textStyle15),
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
