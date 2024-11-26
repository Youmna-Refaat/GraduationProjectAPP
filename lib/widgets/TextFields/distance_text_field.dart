import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';

class DistanceTextField extends StatelessWidget {
  const DistanceTextField({
    super.key,
    required this.distanceController,
  });

  final TextEditingController distanceController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: TextField(
        controller: distanceController,
        decoration: InputDecoration(
          hintText: 'Enter the Distance',
          hintStyle: TextStyle(color: kTextColor.withOpacity(0.6)),
          filled: true,
          fillColor: kPrimaryColor.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Padding(
            padding: EdgeInsets.only(
              right: 20,
              top: 10,
              bottom: 10,
            ),
          ),
        ),
      ),
    );
  }
}
