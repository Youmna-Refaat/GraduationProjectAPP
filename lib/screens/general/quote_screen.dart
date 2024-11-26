import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/general/register.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const RegisterPage(), // Navigate to the quote screen
        ),
      );
    });
    return const Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/quote.png'),
        ),
      ),
    );
  }
}
