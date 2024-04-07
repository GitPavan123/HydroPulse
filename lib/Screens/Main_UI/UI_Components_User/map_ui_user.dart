import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class MapPageUser extends StatefulWidget {
  final String email;

  const MapPageUser({Key? key, required this.email}) : super(key: key);

  @override
  State<MapPageUser> createState() => _MapPageUserState();
}

class _MapPageUserState extends State<MapPageUser> {
  PickedFile? _pickedImage;
  Completer<GoogleMapController> _controller = Completer();

  void _showHistoryPopup4(BuildContext context) async {
    // Replace these values with the desired coordinates
    double targetLatitude = 13.069532157142627;
    double targetLongitude = 80.23981773174302;
    double zoomLevel = 11.6;

    // Wait for the GoogleMapController to be initialized
    GoogleMapController controller = await _controller.future;

    // Move the camera to the specified coordinates and zoom level
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(targetLatitude, targetLongitude),
        zoomLevel,
      ),
    );

    // Additional actions or UI updates can be added here
    // ...
  }

  String mapTheme = "";
  late BitmapDescriptor markerIcon1;

  late BitmapDescriptor markerIcon2;

  MarkerId? selectedMarker;
  PolygonId? selectedPolygon;

  @override
  void initState() {
    super.initState();
    addCustomIconTank();
    addCustomIconTap();
    DefaultAssetBundle.of(context)
        .loadString("assets/map_theme/dark_map.json")
        .then((value) {
      mapTheme = value;
    });
  }

  Future<void> addCustomIconTank() async {
    markerIcon1 = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      "assets/map_theme/water_tank.png",
    );
    setState(() {});
  }

  Future<void> addCustomIconTap() async {
    markerIcon2 = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      "assets/login_screen/water_tap.png",
    );
    setState(() {});
  }

  void _showSpecifiedCoordinates() async {
    GoogleMapController controller = await _controller.future;

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(13.069532157142627, 80.23981773174302),
        11.6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: const MarkerId("Accident has occured!"),
            position: const LatLng(13.069532157142627, 80.23981773174302),
            draggable: false,
            onDragEnd: (value) {},
            icon: markerIcon1,
            onTap: () async {
              _showHistoryPopup3(context, widget.email);

              print("Marker Tapped: Water Tank 1");
              setState(() {
                if (selectedMarker == MarkerId("Accident has occured!")) {
                  selectedPolygon = null;
                  selectedMarker = null;
                } else {
                  selectedPolygon = PolygonId("1");
                  selectedMarker = MarkerId("Accident has occured!");
                }
              });

              GoogleMapController controller = await _controller.future;

              controller.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(13.069532157142627, 80.23981773174302),
                ),
              );
            },
            consumeTapEvents: true,
            infoWindow: InfoWindow(
              title: '',
              snippet: '',
            ),
          ),
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(13.069532157142627, 80.23981773174302),
          zoom: 11.6,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () {
            _showHistoryPopup4(context);
          },
          tooltip: 'Show Coordinates',
          child: Icon(
            Icons.gps_fixed,
            color: Theme.of(context).iconTheme.color,
          ),
          backgroundColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}

void _showHistoryPopup1(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF012C3F),
        title: Text(
          "Ghandipark Services",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        content: Container(
          width: 800,
          height: 260,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
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
                          Text("  Name : Kumaresan.G",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          Text("  Phone No : 9341653427",
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
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
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
                          Text("  Name : Maaran.E",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          Text("  Phone No : 8965423161",
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
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
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
                          Text("  Name : Eashwar.R",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          Text("  Phone No : 8754325162",
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
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showHistoryPopup2(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF012C3F),
        title: Text(
          "Sabari Garden Services",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        content: Container(
          width: 800,
          height: 170,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                          Text("  Name : Mathivadanan.R",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          Text("  Phone No : 9752341623",
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
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
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
                          Text("  Name : Ramesh Kumar.N",
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          Text("  Phone No : 8523145326",
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
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

void _showHistoryPopup3(BuildContext context, String email) {
  int randomVelocity = generateRandomNumber(18, 22);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFF012C3F),
        title: Text(
          "Accident has occured!",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        content: Container(
          width: 800,
          height: 250,
          child: PageView(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Row(children: [
                        Text(
                          "  Vehicle type: Bike",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        )
                      ]),
                      Row(children: [
                        Text(
                          "  Brand: Yamaha",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        )
                      ]),
                      Row(children: [
                        Text(
                          "  Model: R15 V3",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    },
  );
}

final TextEditingController _queryController = TextEditingController();

void snackBar(String? errorMessage) {
  Get.snackbar(
    'Error',
    '$errorMessage',
    snackPosition: SnackPosition.BOTTOM,
    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}

void uploadCollection(String email) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collection = firestore.collection('Complaints');

  DocumentReference document = collection.doc(generateRandomSixDigitNumber());

  DateTime currentDateTime = DateTime.now();

  String formattedDate =
      "${currentDateTime.year}-${currentDateTime.month}-${currentDateTime.day}";
  String formattedTime =
      "${currentDateTime.hour}:${currentDateTime.minute}:${currentDateTime.second}";

  Map<String, dynamic> data = {
    'Date': formattedDate,
    'Time': formattedTime,
    'Complaint': _queryController.text.trim(),
    'E-Mail': email,
  };

  await document.set(data);

  print('Collection uploaded successfully!');
}

String generateRandomSixDigitNumber() {
  Random random = Random();
  int randomNumber = random.nextInt(900000) + 100000;

  return randomNumber.toString();
}

void sendMail(String receiverEmail, String title, String description) async {
  String Username = "waterauthoritycoimbatore@gmail.com";
  String password = "eeka ipln xcsy vvaf";
  final smtpServer = gmail(Username, password);

  final message = Message()
    ..from = Address(Username, 'Water Authority')
    ..recipients.add(receiverEmail)
    ..subject = title
    ..text = description.replaceAll('[recipient email]', receiverEmail);
  try {
    await send(message, smtpServer);
  } catch (e) {
    print('Error occurred: $e');
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

class BumpClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DottedOutline extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  DottedOutline({
    required this.child,
    this.color = Colors.black,
    this.borderWidth = 1.0,
    this.radius = 0.0,
    this.dashWidth = 3.0,
    this.dashSpace = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: color,
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class UploadImageIndicator extends StatelessWidget {
  final VoidCallback onTap;

  UploadImageIndicator({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: Colors.grey,
        strokeWidth: 1,
        borderType: BorderType.RRect,
        radius: Radius.circular(20),
        padding: EdgeInsets.all(8),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt,
                size: 30,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                'Please upload an image',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
