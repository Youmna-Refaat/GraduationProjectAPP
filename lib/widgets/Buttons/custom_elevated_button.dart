import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    this.routingScreen,
    this.onPressed,
    this.onTap,
  });
  final String text;
  final double width, height, radius;
  final Widget? routingScreen;
  final VoidCallback? onTap;
  final void Function()? onPressed;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  TextEditingController user = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.routingScreen!,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          child: Center(
            child: Center(
              child: Text(
                widget.text,
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
      ),
    );
  }
}
