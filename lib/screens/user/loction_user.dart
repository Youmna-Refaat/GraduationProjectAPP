import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/map_for_user_location.dart';

class UserLocation extends StatelessWidget {
  const UserLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UserAppBar(title: 'Location'),
      bottomNavigationBar: UserBottomAppBar(),
      backgroundColor: kTextColor,
      body: MapForUserLocation(),
    );
  }
}
