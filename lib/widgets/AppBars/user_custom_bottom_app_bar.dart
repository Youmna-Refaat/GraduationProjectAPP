import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/general/register.dart';
import 'package:graduation_application/screens/user/alerts_user.dart';
import 'package:graduation_application/screens/user/home_page_user.dart';
import 'package:graduation_application/widgets/AppBars/bottom_app_bar_items.dart';

class UserBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 50.0;
  const UserBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomAppBarItem(
              icon: FontAwesomeIcons.bell,
              title: 'Alert',
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(const UserAlerts()),
                );
              },
            ),
            BottomAppBarItem(
              icon: Icons.home,
              title: 'Home',
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(const UserHomePage()),
                );
              },
            ),
            BottomAppBarItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(const RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
