import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/health_details._child.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/custom_check_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChildHealthEdit extends StatefulWidget {
  const ChildHealthEdit({super.key});

  @override
  State<ChildHealthEdit> createState() => _ChildHealthEditState();
}

class _ChildHealthEditState extends State<ChildHealthEdit> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  List<String> selectedHealthProblems = [];

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
          selectedHealthProblems = items;
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

  Future<void> updateChildHealthProblems(List<String> items) async {
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
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          "items": items,
        });
      } else {
        await checkMenuCollection.add({
          "items": items,
        });
      }
    } catch (e) {
      //ToDo
    }
  }

  void updateSelectedItems(List<String> items) {
    setState(() {
      selectedHealthProblems = items;
    });
    updateChildHealthProblems(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor,
      bottomNavigationBar: const UserBottomAppBar(),
      appBar: const CustomAppBar(
        title: 'Health Problems',
        icon: FontAwesomeIcons.check,
        routingPage: ChildHealthDetails(),
        backPage: ChildHealthDetails(),
      ),
      body: Form(
        key: formkey,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                      left: 20,
                      right: 20,
                      bottom: 25,
                    ),
                    child: Container(
                      width: 460,
                      height: 350,
                      padding: const EdgeInsets.only(
                          top: 25, left: 17, right: 17, bottom: 25),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: CheckMenu(
                        textColor: kTextColor,
                        backgroundColor: kTextFieldColor,
                        onSelectionChanged: updateSelectedItems,
                        initialSelections: selectedHealthProblems,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
