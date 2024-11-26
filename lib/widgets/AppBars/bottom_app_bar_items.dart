import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class BottomAppBarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const BottomAppBarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 35,
          ),
          Text(
            title,
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                color: kTextColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
