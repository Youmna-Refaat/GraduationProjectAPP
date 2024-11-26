import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/screens/child/sign_up.dart';
import 'package:graduation_application/screens/general/signup.dart';
import 'package:graduation_application/screens/user/signup_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_icon_button.dart';

class TypeSignup extends StatelessWidget {
  const TypeSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Signup',
        backPage: SignUpPage(),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login_page.jpeg',
            fit: BoxFit.cover,
            color: const Color.fromRGBO(255, 255, 255, 0.5),
            colorBlendMode: BlendMode.modulate,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconElevatedButton(
                  text: 'Normal mode',
                  width: 260,
                  height: 60,
                  radius: 15,
                  routingScreen: UserSignupPage(),
                  icon: Icons.person_3_rounded,
                ),
                SizedBox(height: 20), // Add space between buttons

                IconElevatedButton(
                  text: 'Child mode',
                  width: 260,
                  height: 60,
                  radius: 15,
                  routingScreen: SupervisorSignupPage(),
                  icon: FontAwesomeIcons.child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
