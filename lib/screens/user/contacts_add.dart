import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/contacts_page.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/AppBars/user_custom_bottom_app_bar.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';

class ContactsAddPage extends StatefulWidget {
  const ContactsAddPage({super.key});

  @override
  State<ContactsAddPage> createState() => _ContactsAddPageState();
}

class _ContactsAddPageState extends State<ContactsAddPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  TextEditingController contactController = TextEditingController();

  Future<void> saveContact() async {
    try {
      setState(() {
        isLoading = true;
      });
      User? user = FirebaseAuth.instance.currentUser;
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);
      QuerySnapshot contactsSnapshot =
          await userDoc.collection('emergency_contacts').get();

      if (contactsSnapshot.docs.length >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maximum 3 contacts allowed')),
        );
        return;
      }

      await userDoc.collection('emergency_contacts').add({
        "contact": int.parse(contactController.text),
      });

      Navigator.pop(context);
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
      appBar: CustomAppBar(
        title: 'Add Contact',
        icon: FontAwesomeIcons.check,
        onIconPressed: saveContact,
        backPage: const ContactsPage(),
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
                      height: 300,
                      padding: const EdgeInsets.only(
                          top: 50, left: 17, right: 17, bottom: 25),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter new contact number',
                            radius: 15,
                            title: 'Emergency Contact',
                            width: 340,
                            height: 50,
                            textColor: kTextColor,
                            hintTextColor: kHintTextColor,
                            backgroundColor: kTextFieldColor,
                            textEditingController: contactController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: saveContact,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Add',
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                    color: kTextColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
