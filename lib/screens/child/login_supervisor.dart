import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_application/constants.dart';
import 'package:graduation_application/helper/show_snackbar.dart';
import 'package:graduation_application/screens/general/register.dart';
import 'package:graduation_application/widgets/AppBars/custom_app_bar.dart';
import 'package:graduation_application/widgets/Buttons/custom_auth_button.dart';
import 'package:graduation_application/widgets/TextFields/custom_text_form_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SupervisorLoginPage extends StatefulWidget {
  const SupervisorLoginPage({super.key});

  @override
  State<SupervisorLoginPage> createState() => _SupervisorLoginPageState();
}

class _SupervisorLoginPageState extends State<SupervisorLoginPage> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: const CustomAppBar(
          title: 'Login',
          backPage: RegisterPage(),
        ),
        body: Center(
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 0.5),
                    const CircleAvatar(
                      radius: 130,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        'assets/images/login.png',
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 320,
                        width: 300,
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
                              height: 50,
                              width: 331,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              onChanged: (data) {
                                email = data;
                              },
                            ),
                            CustomTextFormField(
                              hintText: 'Enter your password',
                              radius: 15,
                              icon: Icons.visibility,
                              title: 'Password',
                              height: 50,
                              width: 331,
                              textColor: kTextColor,
                              hintTextColor: kHintTextColor,
                              backgroundColor: kTextFieldColor,
                              obscureText: true,
                              onChanged: (data) {
                                password = data;
                              },
                            ),
                            CustomAuthButton(
                              text: 'Login',
                              width: 180,
                              height: 50,
                              radius: 10,
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  isLoading = true;
                                  setState(() {});
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: email!, password: password!);
                                    Navigator.pushNamed(
                                        context, 'supervisorHomePage',
                                        arguments: email);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      showSnackBar(context, 'user nor found');
                                    } else if (e.code == 'wrong-password') {
                                      showSnackBar(context, 'wrong password');
                                    }
                                  } catch (e) {
                                    print(e);
                                    showSnackBar(context, 'there was an error');
                                  }
                                  isLoading = false;
                                  setState(() {});
                                } else {}
                              },
                            ),
                          ],
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
