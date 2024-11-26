import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomCheckButton extends StatefulWidget {
  const CustomCheckButton({
    super.key,
    required this.height,
    required this.width,
    required this.label,
    this.routingScreen,
    required this.distance,
  });
  final double height, width, distance;
  final String label;
  final Widget? routingScreen;

  @override
  State<CustomCheckButton> createState() => _CustomCheckButtonState();
}

class _CustomCheckButtonState extends State<CustomCheckButton> {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: kPrimaryColor),
      height: widget.height,
      width: widget.width,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.label,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: widget.distance,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 15,
              height: 15,
              child: Checkbox(
                value: false,
                onChanged: (bool? value) {
                  if (value == true) {
                    if (formkey.currentState!.validate()) {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      Navigator.pushNamed(
                        context,
                        'supervisorSignupPage',
                        arguments: {'email': email, 'password': password},
                      );
                    }
                  }
                },
                shape: const CircleBorder(),
                checkColor: kTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
