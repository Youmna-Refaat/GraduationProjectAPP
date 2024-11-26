import 'package:flutter/material.dart';
import 'package:graduation_application/screens/user/contacts_page.dart';
import 'package:graduation_application/screens/user/health_details_user.dart';
import 'package:graduation_application/screens/user/loction_user.dart';
import 'package:graduation_application/screens/user/vitals_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/home_box.dart';
import 'profile_user.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UserAppBar(title: 'Be Safe'),
      bottomNavigationBar: UserBottomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  HomeBox(
                    image: 'assets/images/profile-high-resolution-logo (1).png',
                    routingPage: UserProfile(),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeBox(
                        image:
                            'assets/images/location-high-resolution-logo (1).png',
                        routingPage: UserLocation(),
                      ),
                      HomeBox(
                        image:
                            'assets/images/vitals-high-resolution-logo (1).png',
                        routingPage: UserVitalsPage(),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeBox(
                        image:
                            'assets/images/contacts-high-resolution-logo.png',
                        routingPage: ContactsPage(),
                      ),
                      HomeBox(
                        image:
                            'assets/images/health-problems-high-resolution-logo.png',
                        routingPage: UserHealthDetails(),
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
    );
  }
}
