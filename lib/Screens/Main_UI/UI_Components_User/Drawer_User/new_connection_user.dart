import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewConnectionUser extends StatefulWidget {
  const NewConnectionUser({super.key});

  @override
  State<NewConnectionUser> createState() => _NewConnectionUserState();
}

class _NewConnectionUserState extends State<NewConnectionUser> {
  final TextEditingController _flatNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Text(
                    " Enter the details:",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
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
                        controller: _flatNoController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          labelText: "Flat NO",
                          prefixIcon: Icon(Icons.numbers_outlined),
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
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
                height: 20,
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
                        controller: _streetController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          labelText: "Street",
                          prefixIcon: Icon(Icons.streetview),
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
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
                height: 20,
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
                        controller: _placeController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          labelText: "Place",
                          prefixIcon: Icon(Icons.place),
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
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
                height: 20,
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
                        controller: _phoneController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          labelText: "Phone No",
                          prefixIcon: Icon(Icons.phone),
                          labelStyle: TextStyle(fontWeight: FontWeight.w600),
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
                height: 23,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 194,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_validateFields()) {
                        String randomDocumentId = _generateRandomDocumentId();

                        Map<String, dynamic> formData = {
                          'FlatNo': _flatNoController.text,
                          'Street': _streetController.text,
                          'Place': _placeController.text,
                          'PhoneNo': _phoneController.text,
                        };

                        try {
                          await FirebaseFirestore.instance
                              .collection('Services')
                              .doc(randomDocumentId)
                              .set(formData);

                          snackBar1("Form submitted successfully");

                          _flatNoController.clear();
                          _streetController.clear();
                          _placeController.clear();
                          _phoneController.clear();
                        } catch (e) {
                          snackBar("Error submitting form: $e");
                        }
                      } else {
                        snackBar("Please fill in all fields");
                      }
                    },
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade900,
                      elevation: 2,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateFields() {
    return _flatNoController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _placeController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
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

void snackBar1(String? errorMessage) {
  Get.snackbar(
    'Success',
    '$errorMessage',
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}

String _generateRandomDocumentId() {
  return (100000 + Random().nextInt(900000)).toString();
}
