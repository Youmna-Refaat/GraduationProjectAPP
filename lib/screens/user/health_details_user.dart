import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/health_edit_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHealthDetails extends StatefulWidget {
  const UserHealthDetails({super.key});

  @override
  _UserHealthDetailsState createState() => _UserHealthDetailsState();
}

class _UserHealthDetailsState extends State<UserHealthDetails> {
  bool isLoading = false;
  List<String> healthProblems = [];

  @override
  void initState() {
    super.initState();
    fetchHealthProblems();
  }

  Future<void> fetchHealthProblems() async {
    setState(() {
      isLoading = true;
    });

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
      if (querySnapshot.docs.isNotEmpty) {
        var docData = querySnapshot.docs.first.data() as Map<String, dynamic>;
        List<String> items = List<String>.from(docData['items']);
        setState(() {
          healthProblems = items;
        });
      }
    } catch (e) {
      //ToDo
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor,
      bottomNavigationBar: const UserBottomAppBar(),
      appBar: const UserAppBar(
        title: 'Health Problems',
        icon: Icons.edit,
        screen: UserHealthEdit(),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 140,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/Online Doctor-rafiki.png',
                      ),
                    ),
                    Container(
                      height: 275,
                      width: 320,
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, bottom: 5),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: healthProblems.map((problem) {
                            return CustomOutputField(
                              height: 50,
                              width: 270,
                              title: '',
                              data: problem,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                            );
                          }).toList(),
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
