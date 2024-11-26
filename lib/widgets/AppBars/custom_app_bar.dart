import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/back_arrow.dart';
import 'package:graduation_application/widgets/custom_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color = kPrimaryColor;
  final IconData? icon;
  final Widget? routingPage, backPage;
  final void Function()? add;
  final void Function()? onIconPressed;
  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
    this.routingPage,
    this.backPage,
    this.add,
    this.onIconPressed,
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
      leading: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: BackArrowIcon(
          onPressed: () {
            if (onIconPressed != null) {
              onIconPressed!();
            }
            if (backPage != null) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return backPage!;
              }));
            }
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: CustomIcon(
            icon: icon,
            onPressed: () {
              if (onIconPressed != null) {
                onIconPressed!();
              }
              if (routingPage != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return routingPage!;
                }));
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
