import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../forgot_otp_page.dart';
import 'login_page_user.dart';

class ForgotPasswordUser extends StatefulWidget {
  const ForgotPasswordUser({super.key});

  @override
  State<ForgotPasswordUser> createState() => _ForgotPasswordUserState();
}

class _ForgotPasswordUserState extends State<ForgotPasswordUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                child: Image(
                  image: AssetImage("assets/login_screen/forgot_password.png"),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Forgot \nPassword?",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Enter the E-Mail associated with your account \nto change the password",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  height: 65,
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      cursorOpacityAnimates: true,
                      decoration: InputDecoration(
                        labelText: "E-Mail",
                        prefixIcon: Icon(Iconsax.direct_copy),
                        labelStyle: TextStyle(fontWeight: FontWeight.w600),
                        contentPadding: EdgeInsets.symmetric(vertical: 24),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 2.0),
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
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      String password = "EcoSync@123";
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: password);
                        snackBar("Account with that E-Mail dosen't exist");
                        await FirebaseAuth.instance.currentUser!.delete();
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "email-already-in-use") {
                          Get.to(
                            () => ForgotOTP(
                              email: _emailController.text,
                            ),
                          );
                        } else {
                          snackBar("Please enter a valid E-Mail");
                        }
                      }
                    },
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void snackBar(String? errorMessage) {
    Get.snackbar(
      'Error',
      '$errorMessage',
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10), //
    );
  }
}
