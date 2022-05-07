import 'package:amazonclone/resources/auth_methods.dart';
import 'package:amazonclone/screens/sign_up_screen.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
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
                      height: screenSize.height * 0.6,
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
                            "Sign-In",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 33,
                            ),
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
                                "Sign-In",
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
                                String output = await authMethods.SignInUser(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                if (output == "success") {
                                  //Funcs
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "New to Amazon?",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomMainButton(
                        child: Text(
                          "Create an Amazon account",
                          style: TextStyle(
                            letterSpacing: 0.6,
                            color: Colors.black,
                          ),
                        ),
                        color: Colors.grey[600]!,
                        isLoading: false,
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
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
