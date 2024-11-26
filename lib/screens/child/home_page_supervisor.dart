import 'package:flutter/material.dart';
import 'package:graduation_application/screens/child/child_vitals_page.dart';
import 'package:graduation_application/screens/child/health_details._child.dart';
import 'package:graduation_application/screens/child/profile_supervisor.dart';
import 'package:graduation_application/screens/child/safezones_home_user.dart';
import 'package:graduation_application/screens/child/loction_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/home_box.dart';

class SupervisorHomePage extends StatelessWidget {
  const SupervisorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Be Safe',
      ),
      bottomNavigationBar: SupervisorBottomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeBox(
                      image:
                          'assets/images/profile-high-resolution-logo (1).png',
                      routingPage: SupervisorProfile(),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeBox(
                          image:
                              'assets/images/location-high-resolution-logo (1).png',
                          routingPage: ChildLocation(),
                        ),
                        HomeBox(
                          image:
                              'assets/images/vitals-high-resolution-logo (1).png',
                          routingPage: ChildVitalsPage(),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeBox(
                          image:
                              'assets/images/safe-zones-high-resolution-logo (1).png',
                          routingPage: ChildSafeones(),
                        ),
                        HomeBox(
                          image:
                              'assets/images/health-problems-high-resolution-logo.png',
                          routingPage: ChildHealthDetails(),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
