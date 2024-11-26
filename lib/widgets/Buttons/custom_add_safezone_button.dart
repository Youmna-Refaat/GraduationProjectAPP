import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomAddSafezoneButton extends StatefulWidget {
  const CustomAddSafezoneButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    this.routingScreen,
    this.onPressed,
    required this.locationController,
    required this.distanceController,
    required this.addCustomBox,
    required this.tittleController,
  });

  final String text;
  final double width, height, radius;
  final Widget? routingScreen;
  final void Function()? onPressed;
  final TextEditingController locationController;
  final TextEditingController distanceController;
  final TextEditingController tittleController;

  final void Function(String, String, int, String) addCustomBox;

  @override
  State<CustomAddSafezoneButton> createState() =>
      _CustomAddSafezoneButtonState();
}

class _CustomAddSafezoneButtonState extends State<CustomAddSafezoneButton> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;

  Future<void> addSafezone(String location, int distance, String tittle) async {
    try {
      User? supervisor = FirebaseAuth.instance.currentUser;

      if (supervisor == null) {
        throw Exception("No authenticated user found");
      }

      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('supervisors')
          .doc(supervisor.uid);
      CollectionReference safezoneCollection =
          userDocRef.collection('safezones');

      DocumentReference newSafezoneRef = await safezoneCollection
          .add({"location": location, "distance": distance, "tittle": tittle});

      widget.addCustomBox(newSafezoneRef.id, location, distance, tittle);
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
              String location = widget.locationController.text;
              int distance = int.tryParse(widget.distanceController.text) ?? 0;
              String tittle = widget.tittleController.text;

              await addSafezone(location, distance, tittle);

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
              )),
            ),
          ),
        ),
      ),
    );
  }
}
