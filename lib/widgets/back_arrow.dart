import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';

class BackArrowIcon extends StatelessWidget {
  const BackArrowIcon({super.key, required this.onPressed});
  final IconData back = Icons.arrow_back_ios_new_sharp;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          back,
          size: 35,
          color: kTextColor,
        ),
      ),
    );
  }
}
