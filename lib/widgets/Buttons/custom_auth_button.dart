import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    required this.onPressed,
  });
  final String text;
  final double width, height, radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Center(
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 20,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
