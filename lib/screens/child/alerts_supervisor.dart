import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/alerts_box.dart';
import 'package:graduation_application/widgets/lists/list_alerts.dart';

class SupervisorAlerts extends StatefulWidget {
  const SupervisorAlerts({super.key});

  @override
  State<SupervisorAlerts> createState() => _SupervisorAlertsState();
}

class _SupervisorAlertsState extends State<SupervisorAlerts> {
  List<AlertBox> alerts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor,
      appBar: const UserAppBar(
        title: 'Alerts',
      ),
      bottomNavigationBar: const SupervisorBottomAppBar(),
      body: AlertsList(alerts: alerts),
    );
  }
}
