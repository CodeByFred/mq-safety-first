import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/auth_text_field_padding.dart';
import 'package:mq_safety_first/config/image_constants.dart';
import 'package:mq_safety_first/config/text_constants.dart';
import 'package:mq_safety_first/templates/auth_text_button.dart';
import 'package:mq_safety_first/templates/confirm_password_text_field.dart';
import 'package:mq_safety_first/templates/email_text_field.dart';
import 'package:mq_safety_first/templates/full_name_text_field.dart';
import 'package:mq_safety_first/templates/large_bottom_button.dart';
import 'package:mq_safety_first/templates/password_text_field.dart';

import '../config/color_constants.dart';
import '../config/curve_constants.dart';

class AuthTemplate extends StatelessWidget {
  final String viewTitle;
  final String buttonTitle;
  final String textButtonTitle;
  final bool showNameField;
  final TextEditingController? nameFieldController;
  final bool showEmailField;
  final TextEditingController? emailFieldController;
  final bool showPasswordField;
  final TextEditingController? passwordFieldController;
  final bool showConfirmPasswordField;
  final TextEditingController? confirmPasswordFieldController;

  const AuthTemplate({
    super.key,
    required this.viewTitle,
    required this.buttonTitle,
    required this.textButtonTitle,
    required this.showNameField,
    this.nameFieldController,
    required this.showEmailField,
    this.emailFieldController,
    required this.showPasswordField,
    this.passwordFieldController,
    required this.showConfirmPasswordField,
    this.confirmPasswordFieldController,
  });

  @override
  Widget build(context) {
    // Get the screen size
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    var containerHeight = height * .45;
    var containerWidth = (width * .3) / 2;
    final TextEditingController nameController =
        nameFieldController ?? TextEditingController();
    final TextEditingController emailController =
        nameFieldController ?? TextEditingController();
    final TextEditingController passwordController =
        nameFieldController ?? TextEditingController();
    final TextEditingController confirmPasswordController =
        nameFieldController ?? TextEditingController();

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    deepRed,
                    red,
                    brightRed,
                    magenta,
                    purple,
                  ],
                  stops: [
                    .2,
                    .4,
                    .6,
                    .8,
                    1.0,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: CustomPaint(
                painter: CurvePainter(),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
                child: Column(
                  children: [
                    const MacquarieBanner(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 55.0, 0, 0),
                      child: Text(viewTitle,
                          style: const TextStyle(
                            fontFamily: montserrat,
                            fontSize: 28,
                            color: white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        containerWidth, containerHeight, containerWidth, 0),
                    child: Column(children: [
                      if (showNameField)
                        FullNameTextField(
                          controller: nameController,
                        ),
                      if (showEmailField)
                        AuthTextFieldPadding(
                          child: EmailTextField(
                            controller: emailController,
                          ),
                        ),
                      if (showPasswordField)
                        AuthTextFieldPadding(
                            child: PasswordTextField(
                          controller: passwordController,
                        )),
                      if (showConfirmPasswordField)
                        AuthTextFieldPadding(
                          child: ConfirmPasswordTextField(
                            controller: confirmPasswordController,
                          ),
                        )
                    ]),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  LargeBottomButton(buttonTitle: buttonTitle),
                  AuthTextButton(buttonTitle: textButtonTitle),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
