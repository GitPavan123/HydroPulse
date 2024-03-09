import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:reservoir_startuptn/Screens/Login_screen/Technician/forgot_password_page_technician.dart';
import 'package:reservoir_startuptn/Screens/Main_UI/UI_Components_Technician/bottom_nav_bar_technician.dart';
import 'package:reservoir_startuptn/Screens/Signup_screen/Technician/signup_page_technician.dart';

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}

class LoginScreenTechnician extends StatefulWidget {
  @override
  State<LoginScreenTechnician> createState() => _LoginScreenTechnicianState();
}

class _LoginScreenTechnicianState extends State<LoginScreenTechnician> {
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
                                  value:
                                      _isRememberMeChecked, // Use the boolean variable here
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
                              Get.to(() => ForgotPasswordTechnician());
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
                            Get.to(() => SignupScreenTechnician());
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

  String? email;
  String? name;
  String? password;

  Future<void> login() async {
    fetchData();

    print('Email: $email');
    print('Name: $name');
    print('Password: $password');

    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      snackBar('Please enter the E-Mail and Password');
    } else if (_emailController.text.isEmpty) {
      snackBar('Please enter the E-Mail');
    } else if (_passwordController.text.isEmpty) {
      snackBar('Please enter the Password');
    } else if (_emailController.text.trim() != email) {
      snackBar("Account dosen't exist");
    } else if (_emailController.text.trim() == email &&
        _passwordController.text.trim() != password) {
      snackBar("Incorrect password");
    } else if (_emailController.text.trim() == email &&
        _passwordController.text.trim() == password) {
      Get.to(NavBarTechnician(
        email: _emailController.text.trim(),
      ));
    }
  }

  void fetchData() {
    getDocumentData("Technician_Login", _emailController.text.trim())
        .then((Map<String, String> documentData) {
      if (documentData.isNotEmpty) {
        email = documentData['E-Mail'];
        name = documentData['Name'];
        password = documentData['Password'];
      } else {
        print('Document data is empty or document does not exist.');
      }
    });
  }

  Future<Map<String, String>> getDocumentData(
      String collectionName, String documentName) async {
    try {
      // Initialize Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the specified document
      DocumentReference documentReference =
          firestore.collection(collectionName).doc(documentName);

      // Get the document snapshot
      DocumentSnapshot documentSnapshot = await documentReference.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract data from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Convert dynamic values to strings
        String email = data['E-Mail'].toString();
        String name = data['Name'].toString();
        String password = data['Password'].toString();

        // Create and return a map with the key-value pairs
        return {
          'E-Mail': email,
          'Name': name,
          'Password': password,
        };
      } else {
        // Document does not exist
        print(
            'Document $documentName does not exist in collection $collectionName');
        return {};
      }
    } catch (e) {
      print('Error: $e');
      // Return an empty map in case of an error
      return {};
    }
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
