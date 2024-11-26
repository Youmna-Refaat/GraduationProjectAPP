import 'package:flutter/material.dart';
import 'package:graduation_application/widgets/custom_box.dart';

class SafezonesList extends StatelessWidget {
  final List<CustomBox> safezones;

  const SafezonesList({super.key, required this.safezones});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListView.builder(
        itemCount: safezones.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: safezones[index],
          );
        },
      ),
    );
  }
}
