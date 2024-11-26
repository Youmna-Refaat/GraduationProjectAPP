import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/profile_edit_supervisor.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';

class SupervisorProfile extends StatefulWidget {
  const SupervisorProfile({super.key});

  @override
  _SupervisorProfileState createState() => _SupervisorProfileState();
}

class _SupervisorProfileState extends State<SupervisorProfile> {
  String supervisorId = '';
  String childName = '';
  String height = '';
  String weight = '';
  String age = '';
  Future<void> getChildData() async {
    try {
      User? supervisor = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('supervisors')
          .doc(supervisor!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          supervisorId = userDoc['supervisorID'];
          childName = userDoc['childName'];
          height = userDoc['height'].toString();
          weight = userDoc['weight'].toString();
          age = userDoc['age'].toString();
        });
      }
    } catch (error) {
      //ToDo
    }
  }

  @override
  void initState() {
    getChildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SupervisorBottomAppBar(),
      appBar: UserAppBar(
        title: 'Profile',
        icon: Icons.edit,
        screen: SupervisorProfileEdit(
          onSave: getChildData,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(
                  right: 30,
                ),
                child: const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/profile_avatar.png'),
                  radius: 80,
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 80, 5),
                child: Container(
                  width: 400,
                  height: 460,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomOutputField(
                        height: 45,
                        width: 300,
                        title: 'Supervisorname',
                        data: supervisorId,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                      const SizedBox(height: 10),
                      CustomOutputField(
                        height: 45,
                        width: 300,
                        title: 'Child name',
                        data: childName,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                      const SizedBox(height: 10),
                      CustomOutputField(
                        height: 45,
                        width: 300,
                        title: 'Height',
                        data: height,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                      const SizedBox(height: 10),
                      CustomOutputField(
                        height: 45,
                        width: 300,
                        title: 'Weight',
                        data: weight,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                      const SizedBox(height: 10),
                      CustomOutputField(
                        height: 45,
                        width: 300,
                        title: 'Age',
                        data: age,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
