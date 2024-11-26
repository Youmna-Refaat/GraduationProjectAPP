import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/helper/show_snackbar.dart';
import 'package:graduation_application/screens/general/register.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_auth_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email, password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Sign up',
          backPage: RegisterPage(),
        ),
        body: Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 0.5),
                    const CircleAvatar(
                      radius: 130,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/login.png',
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 320,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomTextFormField(
                            hintText: 'Enter your email',
                            radius: 15,
                            title: 'Email',
                            width: 311,
                            height: 50,
                            textColor: kTextColor,
                            hintTextColor: kHintTextColor,
                            backgroundColor: kTextFieldColor,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          CustomTextFormField(
                            hintText: 'Enter your password',
                            radius: 15,
                            title: 'Password',
                            width: 311,
                            height: 50,
                            textColor: kTextColor,
                            hintTextColor: kHintTextColor,
                            backgroundColor: kTextFieldColor,
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          CustomAuthButton(
                            text: 'Submit',
                            width: 200,
                            height: 50,
                            radius: 15,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                isLoading = true;
                                setState(() {});
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: email!,
                                    password: password!,
                                  );
                                  Navigator.pushReplacementNamed(
                                      context, 'typeSignupPage',
                                      arguments: email);
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    showSnackBar(context, 'weak password');
                                  } else if (e.code == 'email-already-in-use') {
                                    showSnackBar(
                                        context, 'email already exists');
                                  }
                                } catch (e) {
                                  showSnackBar(context, 'there was an error');
                                }
                              }
                              isLoading = false;
                              setState(() {});
                              // showSnackBar(context, 'success');
                            },
                          )
                        ],
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
