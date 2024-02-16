import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mq_safety_first/config/color_constants.dart';
import 'package:mq_safety_first/views/active_session_view.dart';
import 'package:mq_safety_first/views/forgot_password_view.dart';
import 'package:mq_safety_first/views/history_view.dart';
import 'package:mq_safety_first/views/home_view.dart';
import 'package:mq_safety_first/views/login_view.dart';
import 'package:mq_safety_first/views/register_view.dart';
import 'package:mq_safety_first/views/report_issue_view.dart';
import 'package:mq_safety_first/views/settings_view.dart';
import 'package:mq_safety_first/views/verify_email_view.dart';
import 'package:mq_safety_first/views/welcome_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const StateManager(),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeView(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/forgotPassword': (context) => const ForgotPasswordView(),
        '/home': (context) => const HomeView(),
        '/verify': (context) => const VerifyEmailView(),
        '/settings': (context) => const SettingsView(),
        '/history': (context) => const HistoryView(),
        '/report' : (context) => const ReportIssueView(),
        '/activeSession': (context) => const ActiveSessionView(),
      },
    );
  }
}

// ADD COMMENTS
class StateManager extends StatelessWidget {
  const StateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return const WelcomeView();
          case ConnectionState.done:
            return const HomeView();
          default:
            return const CircularProgressIndicator();
    }

        }
      ,
    );
  }
}
