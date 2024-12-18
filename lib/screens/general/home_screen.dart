import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: kTextColor,
        appBar: CustomAppBar(
          title: ' Be Safe',
          icon: FontAwesomeIcons.edit,
        ),
      ),
    );
  }
}
