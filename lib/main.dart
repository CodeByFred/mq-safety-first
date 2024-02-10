import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/views/forgot_password_view.dart';
import 'package:mq_safety_first/views/home_view.dart';
import 'package:mq_safety_first/views/login_view.dart';
import 'package:mq_safety_first/views/register_view.dart';
import 'package:mq_safety_first/views/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'An App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: red),
        useMaterial3: true,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome' : (context) => const WelcomeView(),
        '/login' : (context) => const LoginView(),
        '/register' : (context) => const RegisterView(),
        '/forgotPassword' : (context) => const ForgotPasswordView(),
        '/home' : (context) => const HomeView(),
      },
    );
  }
}


