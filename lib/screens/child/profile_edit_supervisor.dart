import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';

class SupervisorProfileEdit extends StatefulWidget {
  final VoidCallback onSave;

  const SupervisorProfileEdit({super.key, required this.onSave});

  @override
  _SupervisorProfileEditState createState() => _SupervisorProfileEditState();
}

class _SupervisorProfileEditState extends State<SupervisorProfileEdit> {
  final TextEditingController supervisorController = TextEditingController();
  final TextEditingController childController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final CollectionReference supervisors =
      FirebaseFirestore.instance.collection('supervisors');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchChildData();
  }

  Future<void> fetchChildData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? supervisor = FirebaseAuth.instance.currentUser;
      if (supervisor != null) {
        DocumentSnapshot userData = await supervisors.doc(supervisor.uid).get();
        if (userData.exists) {
          supervisorController.text = userData['supervisorID'] ?? '';
          childController.text = userData['childName'] ?? '';
          heightController.text = userData['height'].toString() ?? '';
          weightController.text = userData['weight'].toString() ?? '';
          ageController.text = userData['age'].toString() ?? '';
        }
      }
    } catch (error) {
      //ToDo
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? supervisor = FirebaseAuth.instance.currentUser;
      if (supervisor != null) {
        await supervisors.doc(supervisor.uid).update({
          'supervisorID': supervisorController.text,
          'childName': childController.text,
          'height': double.parse(heightController.text),
          'weight': double.parse(weightController.text),
          'age': int.parse(ageController.text),
        });
        widget.onSave();
        Navigator.pop(context);
      }
    } catch (error) {
      //ToDo
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SupervisorBottomAppBar(),
      appBar: CustomAppBar(
        title: 'Edit Profile',
        icon: FontAwesomeIcons.check,
        onIconPressed: updateUserData,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Container(
                          width: 380,
                          height: 600,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 10,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 15),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Supervisor username',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit your username',
                                radius: 15,
                                textEditingController: supervisorController,
                              ),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Child\'s name',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit user\'s name',
                                radius: 15,
                                textEditingController: childController,
                              ),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Height',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit child\'s height',
                                radius: 15,
                                textEditingController: heightController,
                              ),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Weight',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit child\'s weight',
                                radius: 15,
                                textEditingController: weightController,
                              ),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Age',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit child\'s age',
                                radius: 15,
                                textEditingController: ageController,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
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
