import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/general/type_signup.dart';
import 'package:graduation_application/screens/user/signup_health_problems.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_signup_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_mini_textfield.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserSignupPage extends StatefulWidget {
  const UserSignupPage({super.key});

  @override
  State<UserSignupPage> createState() => _UserSignupPageState();
}

class _UserSignupPageState extends State<UserSignupPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  TextEditingController userID = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController sleepingHours = TextEditingController();

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
          child: Center(
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
                  height: 550,
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
                        title: 'Username',
                        width: 340,
                        height: 50,
                        textColor: kTextColor,
                        hintTextColor: kHintTextColor,
                        backgroundColor: kTextFieldColor,
                        textEditingController: userID,
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
                            hintText: 'Enter your Gender',
                            radius: 15,
                            title: 'Gender',
                            textEditingController: gender,
                          ),
                          const SizedBox(width: 10),
                          MiniCustomTextField(
                            hintText: 'Enter your age ',
                            radius: 15,
                            title: 'Age',
                            textEditingController: age,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MiniCustomTextField(
                            hintText: 'Enter your height',
                            radius: 15,
                            title: 'Height',
                            textEditingController: height,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(width: 10),
                          MiniCustomTextField(
                            hintText: 'Enter your weight',
                            radius: 15,
                            title: 'Weight',
                            textEditingController: weight,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 15),
                      CustomSignupButton(
                        text: 'Next',
                        width: 200,
                        height: 50,
                        radius: 15,
                        routingScreen: const UserSignupHealthProblems(),
                        formKey: formkey,
                        userController: userID,
                        genderController: gender,
                        ageController: age,
                        heightController: height,
                        weightController: weight,
                        contactController: contact,
                      )
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
