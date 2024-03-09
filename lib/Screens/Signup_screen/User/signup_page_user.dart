import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../Login_screen/User/login_page_user.dart';
import 'otp_verification_page_user.dart';

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class SignupScreenUser extends StatefulWidget {
  const SignupScreenUser({Key? key});

  @override
  State<SignupScreenUser> createState() => _SignupScreenUserState();
}

class _SignupScreenUserState extends State<SignupScreenUser> {
  void initState() {
    super.initState();
  }

  bool _isRememberMeChecked = false;
  final _auth = FirebaseAuth.instance;
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    bool dark = isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Get.to(() => LoginScreenUser());
          },
        ),
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
      ),
      backgroundColor: dark ? Colors.grey.shade900 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 200,
                  child: Image(
                    image: AssetImage("assets/login_screen/enroll_number.png"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Let's get started,",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SizedBox(
                          height: 65,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              cursorOpacityAnimates: true,
                              controller: _unameController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 24),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade900, width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelText: "Username",
                                prefixIcon: Icon(Icons.person_outlined),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SizedBox(
                          height: 65,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              cursorOpacityAnimates: true,
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 24),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade900, width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelText: "E-Mail",
                                prefixIcon: Icon(Iconsax.direct_copy),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        SizedBox(
                          height: 65,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              cursorOpacityAnimates: true,
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 24),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade900, width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Iconsax.eye_copy
                                        : Iconsax.eye_slash_copy,
                                  ),
                                ),
                                prefixIcon: Icon(Iconsax.password_check_copy),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 40,
                          child: Checkbox(
                            value: _isRememberMeChecked,
                            onChanged: (value) {
                              setState(() {
                                _isRememberMeChecked = value!;
                              });
                            },
                            activeColor: Colors.blue.shade900,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .apply(
                                      color: dark ? Colors.grey : Colors.black,
                                    ),
                              ),
                              TextSpan(
                                text: "Privacy Policy ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .apply(
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? Colors.white
                                          : Colors.blue.shade900,
                                      color: dark
                                          ? Colors.white
                                          : Colors.blue.shade900,
                                    ),
                              ),
                              TextSpan(
                                text: "and",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .apply(
                                      color: dark ? Colors.grey : Colors.black,
                                    ),
                              ),
                              TextSpan(
                                text: " Terms of use ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .apply(
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? Colors.white
                                          : Colors.blue.shade900,
                                      color: dark
                                          ? Colors.white
                                          : Colors.blue.shade900,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 240,
                        ),
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            onPressed: _isRememberMeChecked
                                ? () async {
                                    signup();
                                  }
                                : null,
                            child: Text("Next"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                              elevation: 2,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signup() async {
    try {
      if (_unameController.text.trim().isEmpty ||
          _emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        snackBar("Please enter all the fields");
      } else if (isPasswordStrong(_passwordController.text.trim())) {
        bool UsernameExists =
            await checkUsernameExists(_unameController.text.trim());

        if (UsernameExists) {
          snackBar("Username is already in use");
        } else {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          String uid = userCredential.user!.uid;

          Get.to(() => OtpVerificationUser(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim(),
                username: _unameController.text.trim(),
              ));
        }
      } else if (!isPasswordStrong(_passwordController.text.trim())) {
        if (_passwordController.text.trim().length < 6 &&
            _passwordController.text.trim().length > 0) {
          snackBar1("Must be of minimum length 6");
        } else if (_passwordController.text.trim().length >= 6) {
          snackBar1("Must contain an uppercase, lowercase, digit, and symbol");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (isValidEmail(_emailController.text.trim())) {
        if (e.code == "email-already-in-use") {
          snackBar("Account already exists with that E-Mail");
        }
      } else if (!isValidEmail(_emailController.text.trim())) {
        snackBar("Enter a valid E-Mail");
      } else {
        print(e.code);
        snackBar(e.code);
      }
    }
  }

  Future<bool> checkUsernameExists(String Username) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Username')
        .doc(Username)
        .get();

    return documentSnapshot.exists;
  }

  bool isValidEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool isPasswordStrong(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*])[A-Za-z\d!@#\$%^&*]{8,16}$';
    RegExp regex = RegExp(pattern);

    return regex.hasMatch(value);
  }

  void snackBar(String? errorMessage) {
    Get.snackbar(
      'Error',
      '$errorMessage',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  void snackBar1(String? errorMessage) {
    Get.snackbar(
      'Password Error',
      '$errorMessage',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}
