import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/home_page_supervisor.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/map_for_child_location.dart';

class ChildLocation extends StatelessWidget {
  const ChildLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: ' Location',
        backPage: SupervisorHomePage(),
      ),
      bottomNavigationBar: SupervisorBottomAppBar(),
      backgroundColor: kTextColor,
      body: MapForChildLocation(),
    );
  }
}
