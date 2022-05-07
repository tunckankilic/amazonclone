import 'dart:developer';

import 'package:amazonclone/resources/auth_methods.dart';
import 'package:amazonclone/screens/sign_in_screen.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      amazonLogo,
                      height: screenSize.height * 0.10,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      height: screenSize.height * 0.75,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign-Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                            ),
                          ),
                          TextFieldWidget(
                            hint: "Enter Your Name",
                            title: "Name",
                            controller: _nameController,
                            obsText: false,
                          ),
                          TextFieldWidget(
                            hint: "Enter Your Address",
                            title: "Address",
                            controller: _addressController,
                            obsText: false,
                          ),
                          TextFieldWidget(
                            hint: "Enter Your Email",
                            title: "Email",
                            controller: _emailController,
                            obsText: false,
                          ),
                          TextFieldWidget(
                            hint: "Enter Your Password",
                            title: "Password",
                            controller: _passwordController,
                            obsText: true,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                              child: Text(
                                "Sign-Up",
                                style: TextStyle(
                                  letterSpacing: 0.6,
                                  color: Colors.black,
                                ),
                              ),
                              color: yellowColor,
                              isLoading: isLoading,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                String output = await authMethods.signUpUser(
                                  name: _nameController.text,
                                  address: _addressController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (output == "success") {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                                } else {
                                  Utils().showSnackBar(
                                    context: context,
                                    content: output,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomMainButton(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            letterSpacing: 0.6,
                            color: Colors.black,
                          ),
                        ),
                        color: Colors.grey[600]!,
                        isLoading: false,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
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
