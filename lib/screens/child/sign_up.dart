import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/signup_health.dart';
import 'package:graduation_application/screens/general/type_signup.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_supervisor_signup_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_mini_textfield.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SupervisorSignupPage extends StatefulWidget {
  const SupervisorSignupPage({super.key});

  @override
  State<SupervisorSignupPage> createState() => _SupervisorSignupPageState();
}

class _SupervisorSignupPageState extends State<SupervisorSignupPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  String? email, password;
  TextEditingController childName = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController sleepingHours = TextEditingController();
  TextEditingController supervisorID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Sign up',
          backPage: TypeSignup(),
        ),
        body: Form(
          key: formkey,
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: Container(
                        width: 460,
                        height: 680,
                        padding: const EdgeInsets.only(
                            top: 25, left: 17, right: 17, bottom: 25),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomTextFormField(
                              hintText: 'Enter your name',
                              radius: 15,
                              title: 'Supervisor name',
                              width: 340,
                              height: 50,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              textEditingController: supervisorID,
                            ),
                            CustomTextFormField(
                              hintText: 'Enter child\'s name',
                              radius: 15,
                              title: 'Child name',
                              width: 340,
                              height: 50,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              textEditingController: childName,
                            ),
                            CustomTextFormField(
                              hintText: 'Enter phone number',
                              radius: 15,
                              title: 'Emergency contact',
                              width: 340,
                              height: 50,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              textEditingController: contact,
                              keyboardType: TextInputType.number,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MiniCustomTextField(
                                  hintText: 'Ente child\'s Gender',
                                  radius: 15,
                                  title: 'Gender',
                                  textEditingController: gender,
                                ),
                                const SizedBox(width: 10),
                                MiniCustomTextField(
                                  hintText: 'Enter child\'s age ',
                                  radius: 15,
                                  title: 'Age',
                                  textEditingController: age,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MiniCustomTextField(
                                  hintText: 'Ente child\'s height',
                                  radius: 15,
                                  title: 'Height',
                                  textEditingController: height,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(width: 10),
                                MiniCustomTextField(
                                  hintText: 'Ente child\'s weight',
                                  radius: 15,
                                  title: 'Weight',
                                  textEditingController: weight,
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            CustomChildSignupButton(
                              text: 'Next',
                              width: 200,
                              height: 50,
                              radius: 15,
                              routingScreen:
                                  const SupervisorSignupHealthProblems(),
                              genderController: gender,
                              ageController: age,
                              heightController: height,
                              weightController: weight,
                              contactController: contact,
                              childController: childName,
                              supervisorController: supervisorID,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
