import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mq_safety_first/main.dart';

class FirebaseCloudStorage {
  final sms = FirebaseFirestore.instance.collection('messages');
  final email = FirebaseFirestore.instance.collection('mail');

  // Private constructor
  FirebaseCloudStorage._privateConstructor();

  // Static private instance of the class
  static final FirebaseCloudStorage _instance =
      FirebaseCloudStorage._privateConstructor();

  // Factory constructor to return the same instance
  factory FirebaseCloudStorage() {
    return _instance;
  }

  String formatPhoneNumber(String phoneNumber) {
    // Check if the phone number is 10 digits
    if (phoneNumber.length != 10) {
      throw ArgumentError('Phone number must be 10 digits long.');
    }
    // Strip off the first digit
    String strippedNumber = phoneNumber.substring(1);
    // Add '+61' to the start
    String formattedNumber = '+61$strippedNumber';
    return formattedNumber;
  }

  // Example method
  void sendSms() async {
    sms.add({
      'to': formatPhoneNumber(GlobalVariables().buddyPhone),
      'body':
      '''Alarm Activated
      Username: ${GlobalVariables().userName}
      Phone: ${GlobalVariables().userPhone}
      Building: ${GlobalVariables().building}
      Lab Type: ${GlobalVariables().labType}
      Activity Name: ${GlobalVariables().activityName}
      Role: ${GlobalVariables().role}'''
    });
  }
    void sendEmail() async {
      email.add({
        'to': GlobalVariables().buddyEmail,
        'message': {
          'subject': 'Macquarie University Safety First Alarm Activated',
          'html': '''
  Username: ${GlobalVariables().userName}<br>
  Phone: ${GlobalVariables().userPhone}<br>
  Building: ${GlobalVariables().building}<br>
  Lab Type: ${GlobalVariables().labType}<br>
  Activity Name: ${GlobalVariables().activityName}<br>
  Role: ${GlobalVariables().role}<br>'''
      }});
    }
  }