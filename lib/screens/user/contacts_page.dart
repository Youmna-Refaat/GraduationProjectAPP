import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/contacts_add.dart';
import 'package:graduation_application/screens/user/contacts_edit%20.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_output_field.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kTextFieldColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ContactsAddPage();
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: kTextColor,
      bottomNavigationBar: const UserBottomAppBar(),
      appBar: const UserAppBar(
        title: 'Emergency Contacts',
        icon: Icons.edit,
        screen: ContactsEditPage(),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('emergency_contacts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<Map<String, dynamic>> emergencyContacts = snapshot
                    .data!.docs
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                if (emergencyContacts.length > 3) {
                  emergencyContacts = emergencyContacts.sublist(0, 3);
                }

                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/emergency_contacts_avatar.jpg',
                          height: 250,
                        ),
                       
                        Container(
                          height: 320,
                          width: 320,
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListView.builder(
                            itemCount: emergencyContacts.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: CustomOutputField(
                                  height: 50,
                                  width: 270,
                                  title: 'Contact ${index + 1}',
                                  data: emergencyContacts[index]['contact']
                                      .toString(),
                                  textColor: kTextColor,
                                  hintTextColor: kHintTextColor,
                                  backgroundColor: kTextFieldColor,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
