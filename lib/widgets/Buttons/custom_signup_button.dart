import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomSignupButton extends StatefulWidget {
  const CustomSignupButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    this.routingScreen,
    this.onPressed,
    required this.formKey,
    required this.userController,
    required this.genderController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.contactController,
  });

  final String text;
  final double width, height, radius;
  final Widget? routingScreen;
  final void Function()? onPressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController userController;
  final TextEditingController genderController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController contactController;

  @override
  State<CustomSignupButton> createState() => _CustomSignupButtonState();
}

class _CustomSignupButtonState extends State<CustomSignupButton> {
  bool isLoading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<bool> isUserIdUnique(String userId) async {
    final querySnapshot = await users.where('userID', isEqualTo: userId).get();
    return querySnapshot.docs.isEmpty;
  }

  Future<void> addUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String userId = widget.userController.text;

      bool isUnique = await isUserIdUnique(userId);
      if (!isUnique) {
        throw Exception("UserID already exists");
      }

      await users.doc(user!.uid).set({
        "userID": userId,
        "gender": widget.genderController.text,
        "age": int.parse(widget.ageController.text),
        "height": double.parse(widget.heightController.text),
        "weight": double.parse(widget.weightController.text),
      });

      await users.doc(user.uid).collection('emergency_contacts').add({
        "contact": int.parse(widget.contactController.text),
      });

      await users.doc(user.uid).collection('vitals').doc('initialVitals').set({
        "beatsPerMinute": '90',
        "SPO2": '80',
      });

      await users
          .doc(user.uid)
          .collection('locations')
          .doc('initialLocation')
          .set({
        "latitude": 30.623101795663892,
        "longitude": 32.26914399874775,
      });

      // Define the array of notification objects
      List<Map<String, dynamic>> notificationsArray = [
        {"notification": "Notification 1 message", "response": "yes"},
        {"notification": "Notification 2 message", "response": "no"},
      ];

      // Add the notifications array to a single document in the notifications subcollection
      await users
          .doc(user.uid)
          .collection('notifications')
          .doc('allNotifications')
          .set({
        "notifications": notificationsArray,
      });
    } catch (error) {
      // ToDo: handle error
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
            if (widget.formKey.currentState?.validate() ?? false) {
              setState(() {
                isLoading = true;
              });

              try {
                await addUser();
                if (widget.routingScreen != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.routingScreen!,
                    ),
                  );
                }
              } catch (e) {
                // ToDo: handle error
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            } else {}
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
