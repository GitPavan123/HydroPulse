import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:reservoir_startuptn/Screens/Main_UI/UI_Components_Technician/bottom_nav_bar_technician.dart';
import 'package:reservoir_startuptn/Screens/Signup_screen/User/signup_page_user.dart';

class OtpVerificationTechnician extends StatefulWidget {
  final String email;
  final String password;
  final String eid;
  final String name;

  OtpVerificationTechnician(
      {required this.email,
      required this.password,
      required this.eid,
      required this.name});

  @override
  State<OtpVerificationTechnician> createState() =>
      _OtpVerificationTechnicianState();
}

class _OtpVerificationTechnicianState extends State<OtpVerificationTechnician> {
  int _start = 59;

  String? storedOtp;

  late int otp;

  Timer? _timer;
  bool isResendButtonDisabled = true;

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}  ';
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isResendButtonDisabled = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    otp = generateSixDigitRandomNumber();
    print("Sent OTP $otp");

    String pastEmail = widget.email;
    sendMail(widget.email, "E-Mail Verification",
        """Subject: Verify Your Email Address with HydroPulse

Dear $pastEmail,

Thank you for choosing HydroPulse. To complete the verification process for your email address, please use the following One-Time Password (OTP) within the next 10 minutes:

OTP: [$otp]

If you did not initiate this verification process, please disregard this email.

Thank you for your cooperation.

Best Regards,
The HydroPulse Team
""");
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.currentUser!.delete();
            Get.to(() => SignupScreenUser());
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Image(
                      image: AssetImage("assets/login_screen/otp.png"),
                    ),
                  ),
                ),
              ),
              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter the verification code sent to",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              Text(
                widget.email,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timerText,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white60),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              OtpTextField(
                  cursorColor: Colors.white60,
                  numberOfFields: 6,
                  fillColor: Colors.blue.shade900,
                  keyboardType: TextInputType.number,
                  filled: true,
                  onSubmit: (value) {
                    setState(() {
                      storedOtp = value;
                    });
                  }),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                  ),
                  Text(
                    "Don't receive the OTP?",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: isResendButtonDisabled
                        ? null
                        : () {
                            _start = 59;
                            otp = generateSixDigitRandomNumber();

                            sendMail(widget.email, "E-Mail Verification",
                                """Subject: Verify Your Email Address with HydroPulse

Dear [recipient email],

Thank you for choosing HydroPulse. To complete the verification process for your email address, please use the following One-Time Password (OTP) within the next 10 minutes:

OTP: [$otp]

If you did not initiate this verification process, please disregard this email.

Thank you for your cooperation.

Best Regards,
The HydroPulse Team
""");
                            startTimer();
                            isResendButtonDisabled = true;
                          },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color:
                            isResendButtonDisabled ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      if (storedOtp != null) {
                        if (int.parse(storedOtp!) == otp) {
                          await FirebaseFirestore.instance
                              .collection('Technician_Login')
                              .doc(widget.email) // Use email as the document ID
                              .set({
                            'Name': widget.name,
                            'E-Mail': widget.email,
                            'Password': widget.password,
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavBarTechnician(
                                email: widget.email,
                              ),
                            ),
                          );
                        } else {
                          Get.snackbar(
                            'Error',
                            'OTP entered is incorrect',
                            snackPosition: SnackPosition.BOTTOM,
                            margin: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                          );
                        }
                      } else if (storedOtp == null) {
                        Get.snackbar(
                          'Error',
                          'Please enter the OTP',
                          snackPosition: SnackPosition.BOTTOM,
                          margin:
                              EdgeInsets.only(bottom: 20, left: 10, right: 10),
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Error during OTP verification: $e',
                        snackPosition: SnackPosition.BOTTOM,
                        margin:
                            EdgeInsets.only(bottom: 20, left: 10, right: 10),
                      );
                    }
                  },
                  child: Text("Verify"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue.shade900,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendMail(String receiverEmail, String title, String description) async {
    String technicianname = "waterauthoritycoimbatore@gmail.com";
    String password = "eeka ipln xcsy vvaf";
    final smtpServer = gmail(technicianname, password);

    final message = Message()
      ..from = Address(technicianname, 'Water Authority')
      ..recipients.add(receiverEmail)
      ..subject = title
      ..text = description.replaceAll('[recipient email]', widget.email);

    try {
      await send(message, smtpServer);
      snackBar1("OTP sent successfully");
    } catch (e) {
      print('Error occurred: $e');
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

  int generateSixDigitRandomNumber() {
    var otp = new Random();
    return otp.nextInt(900000) + 100000;
  }
}
