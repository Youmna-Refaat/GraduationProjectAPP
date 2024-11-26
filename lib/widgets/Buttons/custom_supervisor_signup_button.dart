import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';

class CustomChildSignupButton extends StatefulWidget {
  const CustomChildSignupButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    required this.radius,
    this.routingScreen,
    this.onPressed,
    required this.genderController,
    required this.ageController,
    required this.heightController,
    required this.weightController,
    required this.contactController,
    required this.supervisorController,
    required this.childController,
  });
  final String text;
  final double width, height, radius;
  final Widget? routingScreen;
  final void Function()? onPressed;
  final TextEditingController childController;
  final TextEditingController genderController;
  final TextEditingController ageController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController contactController;
  final TextEditingController supervisorController;

  @override
  State<CustomChildSignupButton> createState() =>
      _CustomChildSignupButtonState();
}

class _CustomChildSignupButtonState extends State<CustomChildSignupButton> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  CollectionReference supervisors =
      FirebaseFirestore.instance.collection('supervisors');

  Future<bool> isUserIdUnique(String supervisorId) async {
    final querySnapshot =
        await supervisors.where('supervisorID', isEqualTo: supervisorId).get();
    return querySnapshot.docs.isEmpty;
  }

  Future<void> addSupervisor() async {
    try {
      isLoading = true;
      User? supervisor = FirebaseAuth.instance.currentUser;
      String supervisorId = widget.supervisorController.text;

      bool isUnique = await isUserIdUnique(supervisorId);
      if (!isUnique) {
        throw Exception("supervisor name already exists");
      }

      await supervisors.doc(supervisor!.uid).set({
        "supervisorID": supervisorId,
        "childName": widget.childController.text,
        "gender": widget.genderController.text,
        "age": int.parse(widget.ageController.text),
        "height": double.parse(widget.heightController.text),
        "weight": double.parse(widget.weightController.text),
        "contact": int.parse(widget.contactController.text),
      });

      await supervisors
          .doc(supervisor.uid)
          .collection('vitals')
          .doc('initialVitals')
          .set({
        "beatsPerMinute": '90',
        "SPO2": '80',
      });

      await supervisors
          .doc(supervisor.uid)
          .collection('locations')
          .doc('initialLocation')
          .set({
        "latitude": 30.592924469100307,
        "longitude": 32.2837427091624,
      });
    } catch (error) {
      //ToDo
      isLoading = false;
      setState(() {});
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
              await addSupervisor();
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
