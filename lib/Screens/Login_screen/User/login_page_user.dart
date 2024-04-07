import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:insurance_Dapp/Screens/Login_screen/User/forgot_password_page_user.dart';
import 'package:insurance_Dapp/Screens/Main_UI/UI_Components_User/bottom_nav_bar_user.dart';

import '../../Signup_screen/User/signup_page_user.dart';

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class LoginScreenUser extends StatefulWidget {
  @override
  State<LoginScreenUser> createState() => _LoginScreenUserState();
}

class _LoginScreenUserState extends State<LoginScreenUser> {
  bool _isRememberMeChecked = false;

  String technicianType = '';
  final _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? errorMessage;

  bool _isObscured = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool dark = isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? Colors.grey.shade900 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 56,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  Container(
                    height: 80,
                    child: Image(
                      image: AssetImage("assets/login_screen/logo.png"),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome back,",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Dive into HydroPulse, where community-driven efforts shape a water-resilient future.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey.shade400),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    children: [
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
                                  labelText: "E-Mail",
                                  prefixIcon: Icon(Iconsax.direct_copy),
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
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
                                        color: Colors.blue.shade900,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
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
                                obscureText: _isObscured,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  labelText: "Password",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
                                    child: Icon(_isObscured
                                        ? Iconsax.eye_slash_copy
                                        : Iconsax.eye_copy),
                                  ),
                                  prefixIcon: Icon(Iconsax.password_check_copy),
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
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
                                        color: Colors.blue.shade900,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 40,
                                child: Checkbox(
                                  activeColor: Colors.blue.shade900,
                                  value: _isRememberMeChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      _isRememberMeChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => ForgotPasswordUser());
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.lightBlue.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            login();
                          },
                          child: Text("Login"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue.shade900,
                            elevation: 2,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 1.5,
                              color: Colors.grey.shade400,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => SignupScreenUser());
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                color:
                                    dark ? Colors.grey[400] : Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      Get.to(NavBarUser(
        email: _emailController.text.trim(),
      ));
    } on FirebaseAuthException catch (e) {
      if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
        snackBar('Please enter the E-Mail and Password');
        print(e.code);
      } else if (_emailController.text.isEmpty) {
        snackBar('Please enter the E-Mail');
        print(e.code);
      } else if (_passwordController.text.isEmpty) {
        snackBar('Please enter the Password');
        print(e.code);
      } else {
        snackBar('You have entered an invalid E-Mail or Password');
        print(e.code);
      }
    }
  }

  void snackBar(String? errorMessage) {
    Get.snackbar(
      'Error',
      '$errorMessage',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}
