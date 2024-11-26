import 'package:flutter/material.dart';
import 'package:graduation_application/widgets/alerts_box.dart';

class AlertsList extends StatelessWidget {
  final List<AlertBox> alerts;

  const AlertsList({super.key, required this.alerts});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: alerts[index],
              );
            }),
      ),
    );
  }
}
