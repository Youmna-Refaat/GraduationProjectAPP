import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';

class LocationTextField extends StatelessWidget {
  const LocationTextField({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 60,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter the location',
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
