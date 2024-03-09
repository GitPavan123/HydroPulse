import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YearlyMaintenanceTechnician extends StatefulWidget {
  late TextEditingController _addressController;

  YearlyMaintenanceTechnician({Key? key}) : super(key: key) {
    _addressController = TextEditingController();
  }

  @override
  State<YearlyMaintenanceTechnician> createState() => _YearlyMaintenanceTechnicianState();
}

class _YearlyMaintenanceTechnicianState extends State<YearlyMaintenanceTechnician> {
  List<String> selectedOptions = [];
  List<String> dropdownOptions = [
    'Overhead Tank',
    'Sump',
    'Pipeline cleaning',
    // Add more options as needed
  ];

  Map<String, double> optionPrices = {
    'Overhead Tank': 500.0,
    'Sump': 1000.0,
    'Pipeline cleaning': 1200.0,
    // Add more options and prices as needed
  };

  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Container(
                  width: 350,
                  height: 700,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Yearly maintenance services:",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
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
                                controller: widget._addressController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  labelText: "Address",
                                  prefixIcon: Icon(Icons.location_city),
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
                      SizedBox(height: 20),
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
                                controller: widget._addressController,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 24),
                                  labelText: "Contact No",
                                  prefixIcon: Icon(Icons.phone_android),
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
                      SizedBox(height: 20),
                      // Dropdown with multiple options
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Options',
                          prefixIcon: Icon(Icons.check_box),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        items: dropdownOptions.map((String option) {
                          return DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            if (value != null) {
                              if (selectedOptions.contains(value)) {
                                selectedOptions.remove(value);
                              } else {
                                selectedOptions.add(value);
                              }
                              updateTotalAmount();
                            }
                          });
                        },
                        value: null,
                        isDense: true,
                        isExpanded: true,
                        hint: Text('Select Options'),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Display selected options
                      Text('Selected Options: ${selectedOptions.join(', ')}'),
                      SizedBox(height: 20),
                      // Display total amount
                      Text('Total Amount: \₹${totalAmount.toStringAsFixed(2)}'),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          SizedBox(
                            width: 250,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await launch(
                                  "https://buytickets.at/waterauthorityofcoimbatorewater/1138410",
                                  forceSafariVC: false);
                            },
                            child: Text("Pay"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue.shade900,
                              elevation: 2,
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: BorderSide(
                                    color: Colors
                                        .black), // Add this line for a black border
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
          ],
        ),
      ),
    );
  }

  void updateTotalAmount() {
    totalAmount = selectedOptions.fold(0.0, (sum, option) {
      return sum + (optionPrices[option] ?? 0.0);
    });
    setState(() {});
  }
}
