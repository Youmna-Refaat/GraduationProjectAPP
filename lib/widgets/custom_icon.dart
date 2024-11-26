import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, required this.onPressed});

  final IconData? icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(
              icon!,
              size: 30,
              color: kTextColor,
            )
          : const SizedBox(),
    );
  }
}
