import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class NoticePageTechnician extends StatefulWidget {
  final String email;

  NoticePageTechnician({
    required this.email,
  });

  @override
  State<NoticePageTechnician> createState() => _NoticePageTechnicianState();
}

class _NoticePageTechnicianState extends State<NoticePageTechnician> {
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
      snackBar1("Mail sent successfully");
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Complaints').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<DocumentSnapshot> complaints = snapshot.data!.docs;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (int i = 0; i < complaints.length; i++)
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showCustomDialog(
                                      context,
                                      complaints[i]['E-Mail'] ?? '',
                                      complaints[i]['Complaint'] ?? '',
                                      complaints[i].id,
                                    );
                                  },
                                  child: SubContainer(
                                    date: complaints[i]['Date'] ?? '',
                                    complaintID: complaints[i].id ?? '',
                                    index: i,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      i < complaints.length - 1 ? 20.0 : 0.0,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    width: 340,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCustomDialog(BuildContext context, String email, String complaint,
      String complaintID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: 500,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "\nE-Mail: \n$email",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "\n               $complaint ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 150,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          sendMail(
                              widget.email,
                              "Acknowledgement of Pipeline Burst Complaint",
                              """Subject: Acknowledgement of Pipeline Issue

Dear $email,

We appreciate your report on the recent pipeline burst. Our team at the Water Authority of Coimbatore is actively investigating and addressing the issue promptly. 

Your cooperation is valued, and we'll keep you informed of our progress. Feel free to contact us with additional details.

Best regards,
Water Authority of Coimbatore""");

                          // Delete the complaint from Firestore
                          await FirebaseFirestore.instance
                              .collection('Complaints')
                              .doc(complaintID)
                              .delete();

                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text("Approve"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade900,
                          elevation: 2,
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 31),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 181,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white, // Set your desired text color
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Add more text widgets or widgets as needed
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SubContainer extends StatelessWidget {
  final String date;
  final String complaintID;
  final int index;

  SubContainer(
      {required this.date, required this.complaintID, required this.index});

  @override
  Widget build(BuildContext context) {
    double topPadding = (index == 0) ? 25.0 : 0.0;

    return Column(
      children: [
        if (date != null && complaintID != null) ...[
          SizedBox(height: topPadding),
          SizedBox(
            height: 70,
            child: Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage("assets/login_screen/plumber_crop.png"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("  Date : $date",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.white,
                          )),
                      Text("  Complaint ID : $complaintID",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(width: 16),
                ],
              ),
              width: 270,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

void snackBar1(String? errorMessage) {
  Get.snackbar(
    'Success',
    '$errorMessage',
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}
