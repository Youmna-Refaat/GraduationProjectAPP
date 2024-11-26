import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';

class MiniCustomTextField extends StatelessWidget {
  const MiniCustomTextField({
    super.key,
    required this.hintText,
    required this.radius,
    required this.title,
    this.width = 120,
    this.height = 50,
    this.onChanged,
    this.textEditingController,
    this.keyboardType,
    // default width
  });

  final String hintText, title;
  final double radius, width, height;
  final Function(String)? onChanged;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kTextColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: height + 15,
          width: width + 10,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required';
              }
              return null;
            },
            keyboardType: keyboardType,
            controller: textEditingController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                  color: kHintTextColor.withOpacity(0.5), fontSize: 12),
              filled: true,
              fillColor: kTextFieldColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
