import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/screens/child/login_supervisor.dart';
import 'package:graduation_application/screens/general/register.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_icon_button.dart';

import '../user/login_user.dart'; // Import EmailPasswordLoginPage class from email_password_login.dart

class TypeLogin extends StatelessWidget {
  const TypeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login',
        backPage: RegisterPage(),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image with 50% pass-through
          Image.asset(
            'assets/images/login_page.jpeg',
            fit: BoxFit.cover,
            color: const Color.fromRGBO(
                255, 255, 255, 0.5), // Apply 50% pass-through
            colorBlendMode: BlendMode.modulate, // Set blend mode to modulate
          ),
          // Login form
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconElevatedButton(
                  text: 'User',
                  width: 260,
                  height: 60,
                  radius: 15,
                  routingScreen: UserLoginPage(),
                  icon: Icons.person_3_rounded,
                ),
                SizedBox(height: 20), // Add space between buttons

                IconElevatedButton(
                  text: 'Supervisor',
                  width: 260,
                  height: 60,
                  radius: 15,
                  routingScreen: SupervisorLoginPage(),
                  icon: FontAwesomeIcons.binoculars,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
