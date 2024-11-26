import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/alerts_box.dart';
import 'package:graduation_application/widgets/lists/list_alerts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserAlerts extends StatefulWidget {
  const UserAlerts({super.key});

  @override
  State<UserAlerts> createState() => _UserAlertsState();
}

class _UserAlertsState extends State<UserAlerts> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<AlertBox> alerts = [];
  String? userId;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
    _loadAlerts();
    _loadUserId();
  }

  Future<void> _initializeFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null && message.data.containsKey('alertId')) {
        setState(() {
          alerts.add(AlertBox(
            title: message.notification!.title ?? 'No Title',
            subTitle: message.notification!.body ?? 'No Body',
            icon: FontAwesomeIcons.exclamationCircle,
            alertId: message.data['alertId'] ?? 'No AlertId',
            userId: userId ?? '', // Ensure userId is set
          ));
        });
        _saveAlerts(); // Save alerts to shared preferences
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification tap
      if (message.notification != null && message.data.containsKey('alertId')) {
        setState(() {
          alerts.add(AlertBox(
            title: message.notification!.title ?? 'No Title',
            subTitle: message.notification!.body ?? 'No Body',
            icon: FontAwesomeIcons.exclamationCircle,
            alertId: message.data['alertId'] ?? 'No AlertId',
            userId: userId ?? '', // Ensure userId is set
          ));
        });
        _saveAlerts(); // Save alerts to shared preferences
      }
    });

    await FirebaseMessaging.instance.subscribeToTopic("emergency");
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userId');
    });
  }

  Future<void> _saveAlerts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> alertsJson =
        alerts.map((alert) => jsonEncode(alert.toJson())).toList();
    await prefs.setStringList('alerts', alertsJson);
  }

  Future<void> _loadAlerts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? alertsJson = prefs.getStringList('alerts');
    setState(() {
      alerts = alertsJson
              ?.map((json) => AlertBox.fromJson(jsonDecode(json)))
              .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor,
      appBar: const UserAppBar(
        title: 'Alerts',
      ),
      bottomNavigationBar: const UserBottomAppBar(),
      body: AlertsList(alerts: alerts),
    );
  }
}
