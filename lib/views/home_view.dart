import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/templates/floatingSettingsButton.dart';
import 'package:mq_safety_first/templates/home_view_tile.dart';
import 'package:mq_safety_first/templates/home_view_tile_trailing.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';

import '../config/color_constants.dart';
import '../config/text_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          const FloatingSettingsButton(),
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
                          backgroundImage:
                              AssetImage(defaultPicPath),
                          maxRadius: 60,
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
                padding: const EdgeInsets.all(35.0),
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
                        children: const <Widget>[
                          HomeScreenTile(leadingIcon: Icons.business),
                          HomeScreenTile(leadingIcon: Icons.engineering),
                          HomeScreenTile(leadingIcon: Icons.edit),
                          HomeViewTileTrailing(leadingIcon: Icons.update, trailingIcon: Icons.chevron_right),
                          HomeViewTileTrailing(leadingIcon:  Icons.notifications_active, trailingIcon: Icons.chevron_right),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          // SHOULD I MAKE THIS A TEMPLATE SINCE IT IS ON MULTIPLE SCREENS? NOT SURE IF IT'S POSSIBLE
          LargeBottomButton(
            buttonTitle: startSession,
            onPressedLBB: () {},
          ),
        ],
      ),
    );
  }
}
