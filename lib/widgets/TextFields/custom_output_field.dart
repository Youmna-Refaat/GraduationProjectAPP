import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOutputField extends StatelessWidget {
  final String title;
  final dynamic data;
  final double width, height;
  final Color textColor, hintTextColor, backgroundColor; // Add color parameter
  const CustomOutputField({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.data,
    required this.textColor,
    required this.hintTextColor,
    required this.backgroundColor, // Require text color
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: textColor, // Use provided color
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              data.toString(),
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: hintTextColor.withOpacity(0.7), // Use provided color
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
