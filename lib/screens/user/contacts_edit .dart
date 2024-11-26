import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/contacts_page.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';

class ContactsEditPage extends StatefulWidget {
  const ContactsEditPage({super.key});

  @override
  State<ContactsEditPage> createState() => _ContactsEditPageState();
}

class _ContactsEditPageState extends State<ContactsEditPage> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoading = false;

  Future<void> deleteContact(String contactId) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('emergency_contacts')
          .doc(contactId)
          .delete();
    } catch (e) {
      //ToDo
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateContact(String contactId, String newContact) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('emergency_contacts')
          .doc(contactId)
          .update({"contact": int.parse(newContact)});
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
        title: 'Edit Emergency Contacts',
        icon: FontAwesomeIcons.check,
        screen: ContactsPage(),
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
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No contacts found"));
                }
                List<Map<String, dynamic>> emergencyContacts =
                    snapshot.data!.docs
                        .map((doc) => {
                              ...doc.data() as Map<String, dynamic>,
                              "id": doc.id,
                            })
                        .toList();

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
                              String contactId = emergencyContacts[index]["id"];
                              TextEditingController contactController =
                                  TextEditingController(
                                      text: emergencyContacts[index]['contact']
                                          .toString());
                              return Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormField(
                                      hintText: 'Contact ${index + 1}',
                                      radius: 15,
                                      title: '',
                                      width: 200,
                                      height: 40,
                                      textColor: kTextColor,
                                      hintTextColor: kHintTextColor,
                                      backgroundColor: kTextFieldColor,
                                      textEditingController: contactController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    IconButton(
                                      iconSize: 30,
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        deleteContact(contactId);
                                      },
                                    ),
                                  ],
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
