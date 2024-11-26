import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';

class ChildVitalsPage extends StatefulWidget {
  const ChildVitalsPage({super.key});

  @override
  State<ChildVitalsPage> createState() => _ChildVitalsPageState();
}

class _ChildVitalsPageState extends State<ChildVitalsPage> {
  String bpm = 'Loading...';
  String spo2 = 'Loading...';
  @override
  void initState() {
    super.initState();
    fetchVitals();
  }

  Future<void> fetchVitals() async {
    try {
      User? supervisor = FirebaseAuth.instance.currentUser;
      if (supervisor != null) {
        DocumentSnapshot vitalsSnapshot = await FirebaseFirestore.instance
            .collection('supervisors')
            .doc(supervisor.uid)
            .collection('vitals')
            .doc('initialVitals')
            .get();

        if (vitalsSnapshot.exists) {
          setState(() {
            bpm = vitalsSnapshot['beatsPerMinute'] ?? 'No data';
            spo2 = vitalsSnapshot['SPO2'] ?? 'No data';
          });
        } else {
          setState(() {
            bpm = 'No data';
            spo2 = 'No data';
          });
        }
      }
    } catch (e) {
      setState(() {
        bpm = 'Error loading data';
        spo2 = 'Error loading data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const SupervisorBottomAppBar(),
      appBar: const UserAppBar(
        title: ' Vitals',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                    'assets/images/vitals-avatar.png',
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Container(
                    height: 300,
                    width: 320,
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        CustomOutputField(
                          height: 50,
                          width: 270,
                          title: 'Beats per minute',
                          data: bpm,
                          textColor: kTextColor,
                          hintTextColor: kHintTextColor,
                          backgroundColor: kTextFieldColor,
                        ),
                        const SizedBox(height: 35),
                        CustomOutputField(
                          height: 50,
                          width: 270,
                          title: 'SPO2',
                          data: spo2,
                          textColor: kTextColor,
                          hintTextColor: kHintTextColor,
                          backgroundColor: kTextFieldColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
