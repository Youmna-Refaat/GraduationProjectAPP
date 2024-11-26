import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/screens/child/home_page_supervisor.dart';
import 'package:graduation_application/widgets/AppBars/custom_user_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/supervisor_health_signup_button.dart';
import 'package:graduation_application/widgets/custom_check_menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SupervisorSignupHealthProblems extends StatefulWidget {
  const SupervisorSignupHealthProblems({super.key});

  @override
  State<SupervisorSignupHealthProblems> createState() =>
      _SupervisorSignupHealthProblemsState();
}

class _SupervisorSignupHealthProblemsState
    extends State<SupervisorSignupHealthProblems> {
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
                            SupervisorHealthSignupButton(
                              text: 'Submit',
                              width: 200,
                              height: 50,
                              radius: 15,
                              routingScreen: const SupervisorHomePage(),
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
