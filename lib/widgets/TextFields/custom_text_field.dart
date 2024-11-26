import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.radius,
    required this.title,
    this.icon,
    required this.width,
    required this.height,
    required this.textColor,
    required this.hintTextColor,
    required this.backgroundColor,
  });

  final String hintText, title;
  final double radius, width, height;
  final IconData? icon;
  final Color textColor, hintTextColor, backgroundColor; // Add color parameter

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: width,
          height: height,
          child: TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: hintTextColor.withOpacity(0.6)),
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide.none,
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: FaIcon(
                  icon,
                  color: kTextColor,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
