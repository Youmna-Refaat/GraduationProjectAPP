import 'package:flutter/material.dart';
import 'package:graduation_application/screens/child/safezones_home.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/map_for_places.dart';

class ChildSafezonesAdd extends StatelessWidget {
  final Function(String, String, int, String) onAdd;

  ChildSafezonesAdd({super.key, required this.onAdd});

  final TextEditingController locationController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Add Safezone',
        backPage: ChildSafeones(),
      ),
      bottomNavigationBar: const SupervisorBottomAppBar(),
      body: MapForZones(
        onAdd: onAdd,
      ),
    );
  }
}
