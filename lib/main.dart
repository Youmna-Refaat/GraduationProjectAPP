import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/screens/general/splash_screen.dart';
import 'package:graduation_application/screens/general/type_signup.dart';
import 'package:graduation_application/screens/child/home_page_supervisor.dart';
import 'package:graduation_application/screens/user/home_page_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.subscribeToTopic('emergency');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        'Received a message: ${message.notification?.title} ${message.notification?.body}');
  });
  runApp(const BeSafe());
}

Future<void> sendResponse(BuildContext context, String alertId,
    String responseBody, Function onSuccess) async {
  final url = Uri.parse('https://your-cloud-function-url/handleResponse');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'alertId': alertId,
      'response': responseBody,
    }),
  );

  if (response.statusCode == 200) {
    onSuccess();
  } else {
    // Handle failure
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to send response')),
    );
  }
}
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // Handle background message
// }

class BeSafe extends StatelessWidget {
  const BeSafe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          'supervisorHomePage': (context) => const SupervisorHomePage(),
          'userHomePage': (context) => const UserHomePage(),
          'typeSignupPage': (context) => const TypeSignup(),
        });
  }
}
