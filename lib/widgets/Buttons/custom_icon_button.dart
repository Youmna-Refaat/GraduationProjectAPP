import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class IconElevatedButton extends StatelessWidget {
  const IconElevatedButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    required this.routingScreen,
    this.icon,
    x,
  });
  final String text;
  final double width, height, radius;
  final Widget routingScreen;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height, // Set button width
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => routingScreen,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              FaIcon(
                icon,
                size: 25,
                color: kTextColor,
              ),
              const SizedBox(
                width: 30,
              ),
              Center(
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
            ],
          ),
        ),
      ),
    );
  }
}
