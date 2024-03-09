import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flic_button/flic_button.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/config/text_styling_size.dart';
import 'package:mq_safety_first/main.dart';
import 'package:permission_handler/permission_handler.dart';



class ButtonListener with Flic2Listener {
  @override
  void onButtonClicked(Flic2ButtonClick buttonClick) {
    print('button ${buttonClick.button.uuid} clicked');
  }
}

class MyAppFlic extends StatefulWidget {
  const MyAppFlic({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyAppFlic> with Flic2Listener {

  // flic2 starts and isn't scanning
  bool _isScanning = false;

// as we discover buttons, lets add them to a map of uuid/button to show
  Flic2Button? buttonsFound;

// the last click to show we are hearing
  Flic2ButtonClick? _lastClick;

// the plugin manager to use while we are active
  FlicButtonPlugin? flicButtonManager;

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  void getPermissions() async {
    // we need permission to scan for a button please, iOS needs bluetooth
    // permission, whereas android also has scan and connect permissions that
    // we will need before scanning and connecting to Flic 2
    final isGranted = await Permission.bluetooth.request().isGranted &&
        (!Platform.isAndroid ||
            (await Permission.bluetoothScan.request().isGranted &&
                await Permission.bluetoothConnect.request().isGranted));
    if (!isGranted) {
      print('cannot scan for a button when scanning is not permitted');
    } else {
      print('Permissions Granted');
    }
  }

  void _startStopScanningForFlic2() async {
    // start scanning for new buttons
    if (!_isScanning) {
      // flic 2 needs permissions for FINE_LOCATION
      // when on android to perform this action
      if (Platform.isAndroid && !await Permission.location.isGranted) {
        await Permission.location.request();
      }
      flicButtonManager?.scanForFlic2();
    } else {
      // are scanning - cancel that
      flicButtonManager?.cancelScanForFlic2();
    }
    // update the UI
    setState(() {
      _isScanning = !_isScanning;
    });
  }

  void _startStopFlic2() {
    // start or stop the plugin (iOS doesn't stop)
    if (null == flicButtonManager) {
      print('Creating flicbutton manager');
      // we are not started - start listening to FLIC2 buttons
      setState(() => flicButtonManager = FlicButtonPlugin(flic2listener: this));
    } else {
      // // started - so stop
      // print('flicbutton manager already created');
      // flicButtonManager?.disposeFlic2().then((value) => setState(() {
      //       // as the flic manager is disposed, signal that it's gone
      //       flicButtonManager = null;
      //     }));
    }
  }

  void _getButtons() {
    // get all the buttons from the plugin that were there last time
    flicButtonManager?.getFlic2Buttons().then((buttons) {
      // put all of these in the list to show the buttons
      for (var button in buttons) {
        _addButtonAndListen(button);
      }
    });
  }

  void _addButtonAndListen(Flic2Button button) {
    // as buttons are discovered via the various methods, add them
    // to the map to show them in the list on the view
    setState(() {



      // add the button to the map
      buttonsFound = button;
      // and listen to the button for clicks and things
      flicButtonManager?.listenToFlic2Button(button.uuid);

      if(button.connectionState == Flic2ButtonConnectionState.disconnected) {
        flicButtonManager?.connectButton(button.uuid);
      }
    });
  }

  Future<void> _connectDisconnectButton(Flic2Button button) async {
    // if disconnected, connect, else disconnect the button
    if (button.connectionState == Flic2ButtonConnectionState.disconnected) {
      // we need permission to connect to a button please
      if (!await Permission.bluetoothConnect.request().isGranted) {
        print(
            'cannot connect to a button when bluetooth connect is not permitted');
      }
      flicButtonManager?.connectButton(button.uuid);
    } else {
      flicButtonManager?.disconnectButton(button.uuid);
    }
  }

  void _forgetButton(Flic2Button button) {
    // forget the passed button so it disappears and we can search again
    // flicButtonManager?.forgetButton(button.uuid).then((value) {
    //   if (value != null && value) {
    //     // button was removed
        setState(() {
          // remove from the list
          print('Button set to null');
          buttonsFound = null;
          // flicButtonManager?.disconnectButton(button.uuid);
          GlobalVariables().selectedBluetooth = false;
          flicButtonManager!.forgetButton(button.uuid);
        });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: flicButtonManager?.invokation,
        builder: (context, snapshot) {
          return Stack(
            children: [
              Container(
                color: white,
                width: 500,
                height: 350,
                child: Column(
                  children: [
                    if (buttonsFound == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fixedSize: const Size(260, 35),
                                foregroundColor: white,
                                backgroundColor: brightRed),
                            onPressed: () {
                              // create the FLIC 2 manager and initialize it
                              _startStopFlic2();
                              if (flicButtonManager == null) {
                                flicButtonManager?.scanForFlic2();
                              }
                              _startStopScanningForFlic2();
                            },
                            child: Text(
                              _isScanning ? 'Stop Scanning' : 'Pair Button',
                              style: textStyle15White,
                            )),
                      ),

                    if (_isScanning && buttonsFound == null)
                      const Text(
                          textAlign: TextAlign.center,
                          'Hold down button for about 10 seconds or until it appears\n',
                          style: textStyle15Black),
                    // and show the list of buttons we have found at this point

                    if(buttonsFound != null)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 10,
                        shadowColor: black,
                        child: ListTile(
                          tileColor: white,
                          leading: const Icon(Icons.radio_button_on, size: 48),
                          title: Text(
                            '${buttonsFound!.buttonAddr}\n'
                            'battery: (${buttonsFound!.battPercentage}%)\n'
                            'serial: ${buttonsFound!.serialNo}\n',
                            style: textStyle15Black,
                          ),
                          subtitle: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                // fixedSize: const Size(260, 35),
                                foregroundColor: white,
                                backgroundColor: brightRed),
                            onPressed: () {
                              // _getButtons();
                              // _connectDisconnectButton(_buttonsFound!);
                              _forgetButton(buttonsFound!);
                              // buttonsFound = null;
                              _startStopScanningForFlic2();
                              // flicButtonManager = null;
                              print('Unpair selected');
                            },
                            child: const Text(
                              'Unpair',
                              style: textStyle15White,
                            ),
                          ),
                        ),
                      ),
                    ),

                    if (buttonsFound != null)
                      const Text(
                        'To test: single click, double click or hold:\n',
                        style: textStyle15Black,
                      ),

                    if (null != _lastClick && buttonsFound != null)
                      Text(
                        '${_lastClick!.isSingleClick ? 'single click\n' : ''}'
                        '${_lastClick!.isDoubleClick ? 'double click\n' : ''}'
                        '${_lastClick!.isHold ? 'hold\n' : ''}',
                        style: textStyle15Black,
                      )
                    else
                      const Text(
                        ' \n',
                        style: textStyle15Black,
                      ),


                  ],
                ),
              ),
              Positioned(bottom: 20, left: 85, right: 85,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      // fixedSize: const Size(260, 35),
                      foregroundColor: white,
                      backgroundColor: brightRed),
                  onPressed: () {
                    if(_isScanning) {
                    _startStopScanningForFlic2();
                    }
                    // _lastClick = null;
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Close',
                    style: textStyle15White,
                  ),
                ),
              ),
            ],
          );
        }
        // },
        );
  }

  @override
  void onButtonClicked(Flic2ButtonClick buttonClick) {
    // callback from the plugin that someone just clicked a button
    if(buttonClick.isSingleClick)
      print('single click');
     else if(buttonClick.isDoubleClick)
       print('double click');
     else
        print('hold');

    setState(() {
      _lastClick = buttonClick;
    });
  }

  @override
  void onButtonConnected() {
    super.onButtonConnected();
    // this changes the state of our list of buttons, set state for this
    setState(() {
      print('button connected');
      GlobalVariables().selectedBluetooth = true;
    });
  }

  // @override
  // void onButtonUpOrDown(Flic2ButtonUpOrDown button) {
  //   super.onButtonUpOrDown(button);
  //   // this is called when a button is pushed down or released
  //   print(
  //     'button ${button.button.uuid} ${button.isDown ? 'down' : 'up'}',
  //   );
  // }

  @override
  void onButtonDiscovered(String buttonAddress) {
    super.onButtonDiscovered(buttonAddress);
    // this is an address which we should be able to resolve to an actual button right away
    print('button @$buttonAddress discovered');
    // but we could in theory wait for it to be connected and discovered because that will happen too
    flicButtonManager?.getFlic2ButtonByAddress(buttonAddress).then((button) {
      if (button != null) {
        print(
          'button found with address $buttonAddress resolved to actual button data ${button.uuid}',
        );
        // which we can add to the list to show right away
        _addButtonAndListen(button);
      }
    });
  }

  @override
  void onButtonFound(Flic2Button button) {
    super.onButtonFound(button);
    // we have found a new button, add to the list to show
    print('button ${button.uuid} found');
    // and add to the list to show
    _addButtonAndListen(button);
  }

  @override
  void onFlic2Error(String error) {
    super.onFlic2Error(error);
    // something went wrong somewhere, provide feedback maybe, or did you code something in the wrong order?
    print('ERROR: $error');
  }

  @override
  void onPairedButtonDiscovered(Flic2Button button) {
    super.onPairedButtonDiscovered(button);
    print('paired button ${button.uuid} discovered');
    // discovered something already paired (getButtons will return these but maybe you didn't bother and
    // just went right into a scan)
    _addButtonAndListen(button);
  }

  @override
  void onScanCompleted() {
    super.onScanCompleted();
    // scan completed, update the state of our view
    setState(() {
      _isScanning = false;
    });
  }

  @override
  void onScanStarted() {
    super.onScanStarted();
    // scan started, update the state of our view
    setState(() {
      _isScanning = true;
    });
  }
}