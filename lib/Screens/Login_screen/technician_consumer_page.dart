import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservoir_startuptn/Screens/Login_screen/Technician/login_page_technician.dart';
import 'package:reservoir_startuptn/Screens/Login_screen/User/login_page_user.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({super.key});

  @override
  State<DecisionTree> createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 140,
            ),
            Text(
              "Choose Your Role",
              style: GoogleFonts.roboto(
                fontSize: 34,
                fontWeight: FontWeight
                    .bold, // You can adjust the font weight for a professional look
                fontStyle:
                    FontStyle.normal, // You can set it to italic if needed
                // Adjust the color as needed
              ),
            ),
            SizedBox(
              height: 45,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreenTechnician()),
                );
              },
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade800
                          .withOpacity(0.5), // Adjust the color to grey
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2,
                          2), // Adjust the values for the desired shadow direction
                    ),
                  ],
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage(
                              "assets/login_screen/plumber_crop.png"),
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Technician",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreenUser()),
                );
              },
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade800
                          .withOpacity(0.5), // Adjust the color to grey
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(2,
                          2), // Adjust the values for the desired shadow direction
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      width: 120,
                      height: 120,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage("assets/login_screen/customer.png"),
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "User",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
