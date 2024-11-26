import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/health_edit_child.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildHealthDetails extends StatefulWidget {
  const ChildHealthDetails({super.key});

  @override
  _ChildHealthDetailsState createState() => _ChildHealthDetailsState();
}

class _ChildHealthDetailsState extends State<ChildHealthDetails> {
  bool isLoading = false;
  List<String> healthProblems = [];

  @override
  void initState() {
    super.initState();
    fetchChildHealthProblems();
  }

  Future<void> fetchChildHealthProblems() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? supervisor = FirebaseAuth.instance.currentUser;

      if (supervisor == null) {
        throw Exception("No authenticated user found");
      }

      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('supervisors')
          .doc(supervisor.uid);
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
      bottomNavigationBar: const SupervisorBottomAppBar(),
      appBar: const UserAppBar(
        title: 'Health Problems',
        icon: Icons.edit,
        screen: ChildHealthEdit(),
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
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...healthProblems
                                .map((problem) => CustomOutputField(
                                      height: 50,
                                      width: 270,
                                      title: '',
                                      data: problem,
                                      textColor: kTextColor,
                                      hintTextColor: kHintTextColor,
                                      backgroundColor: kTextFieldColor,
                                    )),
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
