import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graduation Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserVitalsPage(),
    );
  }
}

class UserVitalsPage extends StatefulWidget {
  const UserVitalsPage({super.key});

  @override
  _UserVitalsPageState createState() => _UserVitalsPageState();
}

class _UserVitalsPageState extends State<UserVitalsPage> {
  String bpm = 'Loading...';
  String spo2 = 'Loading...';

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.containsKey('hr') && message.data.containsKey('spo2')) {
        setState(() {
          bpm = message.data['hr'];
          spo2 = message.data['spo2'];
        });
      }
    });
    fetchVitals();
  }

  Future<void> fetchVitals() async {
    // Implement your method to fetch initial vitals if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const UserBottomAppBar(),
      appBar: const UserAppBar(title: 'Vitals'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/vitals-avatar.png',
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    height: 300,
                    width: 320,
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        CustomOutputField(
                          height: 50,
                          width: 270,
                          title: 'Beats per minute',
                          data: bpm,
                          textColor: kTextColor,
                          hintTextColor: kHintTextColor,
                          backgroundColor: kTextFieldColor,
                        ),
                        const SizedBox(height: 35),
                        CustomOutputField(
                          height: 50,
                          width: 270,
                          title: 'SPO2',
                          data: spo2,
                          textColor: kTextColor,
                          hintTextColor: kHintTextColor,
                          backgroundColor: kTextFieldColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
