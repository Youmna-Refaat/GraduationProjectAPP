import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/custom_icon.dart';

class UserAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color = kPrimaryColor;
  final IconData? icon;
  final Widget? backScreen, screen;

  const UserAppBar({
    super.key,
    required this.title,
    this.icon,
    this.screen,
    this.backScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.roboto(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            color: kTextColor,
          ),
        ),
      ),
      backgroundColor: kPrimaryColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomIcon(
            icon: icon,
            onPressed: () {
              if (screen != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return screen!;
                  }),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
