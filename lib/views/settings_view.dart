import 'package:flic_button/flic_button.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/text_styling_15.dart';
import 'package:mq_safety_first/templates/floating_top_left_button.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/flic2/flic_methods.dart';
import 'package:permission_handler/permission_handler.dart';

import '../config/color_constants.dart';
import '../config/image_constants.dart';
import '../config/text_constants.dart';

class ButtonListener with Flic2Listener {
  @override
  void onButtonClicked(Flic2ButtonClick buttonClick) {
    print('button ${buttonClick.button.uuid} clicked');
  }
}

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
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/history'),
                                dense: true,
                                tileColor: white,
                                title: const Text('View History',
                                    style: textStyle15),
                                trailing: const Icon(Icons.chevron_right)),
                          ),
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                              dense: true,
                              tileColor: white,
                              title: const Text('Pair Bluetooth Button',
                                  style: textStyle15),
                              trailing: Icon(Icons.bluetooth,
                                  color:
                                      _selectedBluetooth ? Colors.blue : null),
                              onTap: () async {
                                // handleTap();

                                setState(() {
                                  _selectedBluetooth = !_selectedBluetooth;
                                });

                                showDialog(
                                  context: context,
                                  builder: (context) => const Dialog(
                                    child: Column(mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MyAppFlic(),
                                      ],
                                    ),
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
                          Card(
                            elevation: 10,
                            shadowColor: black,
                            child: ListTile(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/report'),
                                dense: true,
                                tileColor: white,
                                title: const Text('Report Issue',
                                    style: textStyle15),
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
