import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class WaterBillUser extends StatefulWidget {
  const WaterBillUser({Key? key}) : super(key: key);

  @override
  State<WaterBillUser> createState() => _WaterBillUserState();
}

class _WaterBillUserState extends State<WaterBillUser> {
  double percent = 0.7; // Adjust the percentage as needed

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 28,
          ),
          Row(children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 12),
              Container(
                child: Center(
                  child: Text(
                    "${formattedDate}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                width: 130,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFF012C3F),
                ),
              ),
              // Back arrow button
            ],
          ),
          SizedBox(height: 8),
          Center(
            child: Container(
              width: 370,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF012C3F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CircularPercentIndicator(
                        radius: 55.0,
                        lineWidth: 11.0,
                        percent: percent,
                        center: Text(
                          "70%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        progressColor: Colors.blue.shade700,
                        backgroundColor: Colors.white,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 27),
                        Text(
                          "Daily limit: 2000 litres",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "       Water utilized : 1400 litres",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "    Litres Exceeded : 0 litres",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.account_balance_outlined),
                    ),
                    Text(
                      "Pavan Kumar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "   CG89361826",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "        Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "        240 INR",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),
                    Container(
                      height: 5 +
                          70, // Set the desired height of the vertical divider
                      width: 1, // Set the width of the vertical divider
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          horizontal: 10), // Adjust the margin as needed
                    ),
                    Column(
                      children: [
                        Text(
                          "  Due Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 0),
                        Text(
                          "   03-02-2024",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Add more widgets as needed
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  height: 1, // Set the desired height of the vertical divider
                  width: 280, // Set the width of the vertical divider
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(
                      horizontal: 10), // Adjust the margin as needed
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "     Your ₹240 bill is due in 6 days.",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Background color
                        onPrimary: Colors.white, // Text color
                        side: BorderSide(
                            color: Colors.black,
                            width: 2), // Border color and width
                        minimumSize:
                            Size(100, 50), // Set specific width and height
                      ),
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text("History"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent, // Background color
                        onPrimary: Colors.white, // Text color
                        side: BorderSide(
                            color: Colors.black,
                            width: 2), // Border color and width
                        minimumSize:
                            Size(170, 50), // Set specific width and height
                      ),
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text("Pay Bill"),
                    )
                  ],
                ),
              ],
            ),
            width: 320,
            height: 240,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF012C3F),
            ),
          ),
        ],
      ),
    );
  }
}
