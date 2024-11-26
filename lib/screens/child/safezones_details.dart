import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/safezones_home.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/activation_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';

class ChildSafezonesDetails extends StatefulWidget {
  final String safezoneId;
  const ChildSafezonesDetails({super.key, required this.safezoneId});
  @override
  State<ChildSafezonesDetails> createState() => _ChildSafezonesDetailsState();
}

class _ChildSafezonesDetailsState extends State<ChildSafezonesDetails> {
  String location = '';
  int distance = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSafezoneDetails();
  }

  Future<void> fetchSafezoneDetails() async {
    try {
      User? supervisor = FirebaseAuth.instance.currentUser;

      if (supervisor == null) {
        throw Exception("No authenticated user found");
      }

      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('supervisors')
          .doc(supervisor.uid);
      DocumentReference safezoneDocRef =
          userDocRef.collection('safezones').doc(widget.safezoneId);

      DocumentSnapshot docSnapshot = await safezoneDocRef.get();

      if (docSnapshot.exists) {
        setState(() {
          location = docSnapshot['location'];
          distance = docSnapshot['distance'];

          isLoading = false;
        });
      } else {}
    } catch (error) {
      //ToDo
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SupervisorBottomAppBar(),
      appBar: const CustomAppBar(
        title: 'Safezones',
        backPage: ChildSafeones(),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                height: 400,
                width: 320,
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: CustomOutputField(
                        height: 60,
                        width: 320,
                        title: 'Location',
                        data: location,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                      ),
                      child: CustomOutputField(
                        height: 60,
                        width: 320,
                        title: 'Distance',
                        data: distance.toString(),
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      width: 200,
                      height: 60,
                      child: ActivationButton(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
