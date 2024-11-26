import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.radius,
    required this.title,
    required this.width,
    required this.height,
    required this.textColor,
    required this.hintTextColor,
    required this.backgroundColor,
    this.icon,
    this.onChanged,
    this.textEditingController,
    this.keyboardType,
    this.obscureText = false,
  });

  final String hintText, title;
  final double radius, width, height;
  final IconData? icon;
  final Color textColor, hintTextColor, backgroundColor; // Add color parameter
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool? obscureText;

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
          height: height + 30,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            obscureText: obscureText!,
            controller: textEditingController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: hintTextColor.withOpacity(0.6)),
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide.none,
              ),
              // suffixIcon: Padding(
              //   padding: const EdgeInsets.only(
              //     right: 20,
              //     top: 10,
              //     bottom: 10,
              //   ),
              //   child: FaIcon(
              //     icon,
              //     color: kTextColor,
              //     size: 28,
              //   ),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
