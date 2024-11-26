import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/safezones_details._user.dart';

class CustomBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final String safezoneId;
  final void Function() onPressed;

  const CustomBox({
    super.key,
    required this.title,
    required this.icon,
    required this.safezoneId,
    required this.onPressed,
    required ChildSafezonesDetails routingScreen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ChildSafezonesDetails(safezoneId: safezoneId);
          }),
        );
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 180,
          width: 330,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: 25,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    icon,
                    size: 35,
                    color: kTextColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
