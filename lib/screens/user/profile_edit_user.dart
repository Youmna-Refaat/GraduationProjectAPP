import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/profile_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';

class UserProfileEdit extends StatefulWidget {
  final VoidCallback onSave;

  const UserProfileEdit({super.key, required this.onSave});

  @override
  _UserProfileEditState createState() => _UserProfileEditState();
}

class _UserProfileEditState extends State<UserProfileEdit> {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await users.doc(user.uid).get();
        if (userData.exists) {
          userIdController.text = userData['userID'] ?? '';
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
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await users.doc(user.uid).update({
          'userID': userIdController.text,
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
      bottomNavigationBar: const UserBottomAppBar(),
      appBar: CustomAppBar(
        title: 'Edit Profile',
        icon: FontAwesomeIcons.check,
        onIconPressed: updateUserData,
        backPage: const UserProfile(),
        //routingPage: const UserProfile(),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Center(
                        child: Container(
                          width: 380,
                          height: 500,
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
                                title: 'Username',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit your username',
                                radius: 15,
                                textEditingController: userIdController,
                              ),
                              CustomTextFormField(
                                height: 50,
                                width: 300,
                                title: 'Height',
                                textColor: kTextColor,
                                hintTextColor: kHintTextColor,
                                backgroundColor: kTextFieldColor,
                                hintText: 'Edit your height',
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
                                hintText: 'Edit your weight',
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
                                hintText: 'Edit your age',
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
