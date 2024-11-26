import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/user/home_page_user.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_health_sigup_button.dart';
import 'package:graduation_application/widgets/custom_check_menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserSignupHealthProblems extends StatefulWidget {
  const UserSignupHealthProblems({super.key});

  @override
  State<UserSignupHealthProblems> createState() =>
      _UserSignupHealthProblemsState();
}

class _UserSignupHealthProblemsState extends State<UserSignupHealthProblems> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  List<String> selectedHealthProblems = [];

  void updateSelectedItems(List<String> items) {
    setState(() {
      selectedHealthProblems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: const UserAppBar(
          title: 'Sign up',
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
                        height: 400,
                        padding: const EdgeInsets.only(
                            top: 25, left: 17, right: 17, bottom: 25),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            CheckMenu(
                              textColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              onSelectionChanged: updateSelectedItems,
                              initialSelections: const [],
                            ),
                            const SizedBox(height: 30),
                            UserHealthSignupButton(
                              text: 'Submit',
                              width: 200,
                              height: 50,
                              radius: 15,
                              routingScreen: const UserHomePage(),
                              selectedItems: selectedHealthProblems,
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
