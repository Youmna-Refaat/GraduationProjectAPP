import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class UserHealthSignupButton extends StatefulWidget {
  const UserHealthSignupButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    this.routingScreen,
    this.onPressed,
    required this.selectedItems,
  });

  final String text;
  final double width, height, radius;
  final Widget? routingScreen;
  final void Function()? onPressed;
  final List<String> selectedItems;

  @override
  State<UserHealthSignupButton> createState() => _UserHealthSignupButtonState();
}

class _UserHealthSignupButtonState extends State<UserHealthSignupButton> {
  final GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;

  Future<void> addOrUpdateCheckMenu(List<String> selectedItems) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("No authenticated user found");
      }

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      CollectionReference checkMenuCollection =
          userDocRef.collection('Health problems');

      QuerySnapshot querySnapshot = await checkMenuCollection.get();
      if (querySnapshot.docs.isEmpty) {
        await checkMenuCollection.add({
          "items": selectedItems,
        });
      } else {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          "items": selectedItems,
        });
      }
    } catch (error) {
      //ToDo
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            try {
              await addOrUpdateCheckMenu(widget.selectedItems);
              if (widget.routingScreen != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.routingScreen!,
                  ),
                );
              }
            } catch (e) {
              //ToDo
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
