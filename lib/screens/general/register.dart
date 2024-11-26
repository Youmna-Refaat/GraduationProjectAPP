import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/general/signup.dart';
import 'package:graduation_application/screens/general/type_login.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_elevated_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserAppBar(title: 'Be Safe'),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/register.jpg', // Change the image path
            fit: BoxFit.cover,
            color: const Color.fromRGBO(
                255, 255, 255, 0.5), // Apply 50% pass-through
            colorBlendMode: BlendMode.modulate, // Set blend mode to modulate
          ),
          Center(
            child: Container(
              width: 280, // Set container width
              height: 245, // Set container height
              decoration: BoxDecoration(
                color: kPrimaryColor
                    .withOpacity(0.5), // Set container color with opacity
                borderRadius: BorderRadius.circular(
                    20.0), // Set border radius for the container
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    text: 'Sign up',
                    width: 210,
                    height: 50,
                    radius: 10,
                    routingScreen: SignUpPage(),
                  ),
                  SizedBox(height: 20), // Add space between buttons
                  CustomElevatedButton(
                    text: 'Login',
                    width: 210,
                    height: 50,
                    radius: 10,
                    routingScreen: TypeLogin(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
