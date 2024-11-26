import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/safezone_add.dart';
import 'package:graduation_application/screens/child/safezones_details.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/supervisor_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/custom_box.dart';
import 'package:graduation_application/widgets/lists/list_safezones.dart';

class ChildSafeones extends StatefulWidget {
  const ChildSafeones({super.key});

  @override
  State<ChildSafeones> createState() => _ChildSafeonesState();
}

class _ChildSafeonesState extends State<ChildSafeones> {
  List<CustomBox> childSafezones = [];

  @override
  void initState() {
    super.initState();
    fetchSafezones();
  }

  Future<void> fetchSafezones() async {
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

      QuerySnapshot querySnapshot = await safezoneCollection.get();

      List<CustomBox> fetchedSafezones = querySnapshot.docs.map((doc) {
        String location = doc['location'];
        int distance = doc['distance'];
        String tittle = doc['tittle'];

        return CustomBox(
          key: ValueKey(doc.id), // Ensure each CustomBox has a unique key
          title: 'Safezone: $tittle',
          icon: FontAwesomeIcons.trash,
          safezoneId: doc.id,
          onPressed: () async {
            await deleteSafezone(doc.id);
          },
          routingScreen: ChildSafezonesDetails(safezoneId: doc.id),
        );
      }).toList();

      setState(() {
        childSafezones = fetchedSafezones;
      });
    } catch (error) {
      print("Failed to fetch safezones: $error");
    }
  }

  Future<void> deleteSafezone(String safezoneId) async {
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

      await safezoneCollection.doc(safezoneId).delete();

      setState(() {
        childSafezones.removeWhere((box) => box.safezoneId == safezoneId);
      });
    } catch (error) {
      print("Failed to delete safezone: $error");
    }
  }

  void addCustomBox(String id, String location, int distance, String tittle) {
    setState(() {
      childSafezones.add(
        CustomBox(
          key: ValueKey(id),
          title: 'Safezone: $tittle',
          icon: FontAwesomeIcons.trash,
          safezoneId: id,
          onPressed: () async {
            await deleteSafezone(id);
          },
          routingScreen: ChildSafezonesDetails(safezoneId: id),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTextColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kTextFieldColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChildSafezonesAdd(
              onAdd: (String id, String location, int distance, String tittle) {
                addCustomBox(id, location, distance, tittle);
              },
            );
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      appBar: const UserAppBar(
        title: 'Safezones',
      ),
      bottomNavigationBar: const SupervisorBottomAppBar(),
      body: SafezonesList(safezones: childSafezones),
    );
  }
}
