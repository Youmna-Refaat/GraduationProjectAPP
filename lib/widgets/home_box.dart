import 'package:flutter/material.dart';

class HomeBox extends StatelessWidget {
  const HomeBox({
    super.key,
    required this.image,
    required this.routingPage,
  });
  final String image;
  final Widget routingPage;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => routingPage),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            image,
            width: 160,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
