import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class ActivationButton extends StatefulWidget {
  const ActivationButton({super.key});

  @override
  State<ActivationButton> createState() => _ActivationButtonState();
}

class _ActivationButtonState extends State<ActivationButton> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActivateButton(
            onPressed: switchValue,
          ),
          Switch(
            activeTrackColor: const Color.fromARGB(255, 139, 181, 204),
            value: switchValue,
            onChanged: (value) {
              setState(() {
                switchValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ActivateButton extends StatelessWidget {
  final bool onPressed;

  const ActivateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ? () {} : null,
      child: Text(
        onPressed ? 'Activated' : 'Deactivated',
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            color: kTextColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
