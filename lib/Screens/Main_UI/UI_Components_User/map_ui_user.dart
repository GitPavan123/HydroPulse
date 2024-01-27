import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageUser extends StatefulWidget {
  const MapPageUser({Key? key}) : super(key: key);

  @override
  State<MapPageUser> createState() => _MapPageUserState();
}

class _MapPageUserState extends State<MapPageUser> {
  String mapTheme = "";
  late BitmapDescriptor markerIcon;
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> peelamedu = const [
    LatLng(11.020260453892645, 76.96413330301858),
    LatLng(11.056246895684264, 76.97106207583438),
    LatLng(11.107243733306012, 76.99069359881247),
    LatLng(11.085712819709578, 77.05247515642),
    LatLng(11.056530235989008, 77.03313233230924),
    LatLng(11.006658131943142, 77.06921969072485),
    LatLng(10.99588918156393, 77.01927478667764)
  ];

  List<LatLng> sabariGarden = const [
    LatLng(11.0181527794094, 76.95294694199826),
    LatLng(11.05719271010531, 76.96267991909573),
    LatLng(11.10758540628997, 76.97682799283031),
    LatLng(11.103460189107157, 76.9682946699914),
    LatLng(11.10909977922588, 76.92881372114631),
    LatLng(11.070846511443227, 76.9095730055699),
    LatLng(11.026074901760454, 76.87316987376826),
    LatLng(11.015350023565594, 76.88535699101239)
  ];

  List<LatLng> ghandipark = const [
    LatLng(11.010479337867539, 76.95373779654031),
    LatLng(10.98696534930167, 76.89532368285303),
    LatLng(10.977476717886635, 76.89868564623072),
    LatLng(10.970050619796318, 76.87010895752039),
    LatLng(10.943645205294237, 76.88313656560891),
    LatLng(10.936218258233714, 76.91885742649683),
    LatLng(10.918887991866967, 76.97601080391749),
    LatLng(10.965434797152689, 77.03136323823921),
    LatLng(11.000112155404025, 76.9971162740542)
  ];

  MarkerId? selectedMarker; // Variable to keep track of selected marker
  PolygonId? selectedPolygon; // Variable to keep track of selected polygon

  @override
  void initState() {
    super.initState();
    addCustomIcon();
    DefaultAssetBundle.of(context)
        .loadString("assets/map_theme/dark_map.json")
        .then((value) {
      mapTheme = value;
    });
  }

  Future<void> addCustomIcon() async {
    markerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      "assets/map_theme/water_tank.png",
    );
    setState(() {});
  }

  void _showSpecifiedCoordinates() async {
    // Get the GoogleMapController from the completer
    GoogleMapController controller = await _controller.future;

    // Animate the camera to the specified coordinates with zoom level 11
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(11.017638730275939, 76.95911594996261),
        11.0,
      ),
    );
  }

//  LatLng(11.04745670520816, 76.92919087637374)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true, // Enable the my location button
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },

        markers: {
          Marker(
            markerId: const MarkerId("Peelamedu Water Tank"),
            position: const LatLng(11.032124056025587, 76.99865509563396),
            draggable: false,
            onDragEnd: (value) {
              // Handle drag end if needed
            },
            icon: markerIcon,
            onTap: () async {
              // Handle marker tap for Water Tank 1
              print("Marker Tapped: Water Tank 1");
              setState(() {
                if (selectedMarker == MarkerId("Peelamedu Water Tank")) {
                  // Clear selected polygon if the same marker is tapped again
                  selectedPolygon = null;
                  selectedMarker = null;
                } else {
                  selectedPolygon = PolygonId("1");
                  selectedMarker = MarkerId("Peelamedu Water Tank");
                }
              });

              // Get the GoogleMapController from the completer
              GoogleMapController controller = await _controller.future;

              // Animate the camera to the selected marker's position
              controller.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(11.032124056025587, 76.99865509563396),
                ),
              );
            },
            consumeTapEvents: true, // Disable default behavior
            infoWindow: InfoWindow(
              // Set an empty InfoWindow to remove the "next" button
              title: '',
              snippet: '',
            ),
          ),
          Marker(
            markerId: const MarkerId("Sabari Garden Water Tank"),
            position: const LatLng(11.04745670520816, 76.92919087637374),
            draggable: false,
            onDragEnd: (value) {
              // Handle drag end if needed
            },
            icon: markerIcon,
            onTap: () async {
              // Handle marker tap for Water Tank 2
              print("Marker Tapped: Water Tank 2");
              setState(() {
                if (selectedMarker == MarkerId("Sabari Garden Water Tank")) {
                  // Clear selected polygon if the same marker is tapped again
                  selectedPolygon = null;
                  selectedMarker = null;
                } else {
                  selectedPolygon = PolygonId("2");
                  selectedMarker = MarkerId("Sabari Garden Water Tank");
                }
              });

              // Get the GoogleMapController from the completer
              GoogleMapController controller = await _controller.future;

              // Animate the camera to the selected marker's position
              controller.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(11.04745670520816, 76.92919087637374),
                ),
              );
            },
            consumeTapEvents: true, // Disable default behavior
            infoWindow: InfoWindow(
              // Set an empty InfoWindow to remove the "next" button
              title: '',
              snippet: '',
            ),
          ),
          Marker(
            markerId: const MarkerId("Ghandipark Water Tank"),
            position: const LatLng(10.962924974186155, 76.95011996827809),
            draggable: false,
            onDragEnd: (value) {
              // Handle drag end if needed
            },
            icon: markerIcon,
            onTap: () async {
              // Handle marker tap for Water Tank 3
              print("Marker Tapped: Water Tank 3");
              setState(() {
                if (selectedMarker == MarkerId("Ghandipark Water Tank")) {
                  // Clear selected polygon if the same marker is tapped again
                  selectedPolygon = null;
                  selectedMarker = null;
                } else {
                  selectedPolygon = PolygonId("3");
                  selectedMarker = MarkerId("Ghandipark Water Tank");
                }
              });

              // Get the GoogleMapController from the completer
              GoogleMapController controller = await _controller.future;

              // Animate the camera to the selected marker's position
              controller.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(10.962924974186155, 76.95011996827809),
                ),
              );
            },
            consumeTapEvents: true, // Disable default behavior
            infoWindow: InfoWindow(
              // Set an empty InfoWindow to remove the "next" button
              title: '',
              snippet: '',
            ),
          ),
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(11.017638730275939, 76.95911594996261),
          zoom: 11,
        ),
        polygons: {
          if (selectedPolygon == PolygonId("1"))
            Polygon(
              polygonId: PolygonId("1"),
              points: peelamedu,
              fillColor: Colors.blue
                  .withOpacity(0.3), // Change the fill color and opacity
              strokeColor:
                  Colors.blue.shade50, // Change the stroke (border) color
              strokeWidth: 2, // Change the stroke (border) width
            ),
          if (selectedPolygon == PolygonId("2"))
            Polygon(
              polygonId: PolygonId("2"),
              points: sabariGarden,
              fillColor: Colors.blue
                  .withOpacity(0.3), // Change the fill color and opacity
              strokeColor:
                  Colors.blue.shade50, // Change the stroke (border) color
              strokeWidth: 2, // Change the stroke (border) width
            ),
          if (selectedPolygon == PolygonId("3"))
            Polygon(
              polygonId: PolygonId("3"),
              points: ghandipark,
              fillColor: Colors.blue
                  .withOpacity(0.3), // Change the fill color and opacity
              strokeColor:
                  Colors.blue.shade50, // Change the stroke (border) color
              strokeWidth: 2, // Change the stroke (border) width
            ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 80.0), // Adjust the margin as needed
        child: FloatingActionButton(
          onPressed: () {
            _showSpecifiedCoordinates();
          },
          tooltip: 'Show Coordinates',
          child: Icon(
            Icons.gps_fixed,
            color: Theme.of(context).iconTheme.color,
          ),
          backgroundColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0), // Adjust the border radius as needed
          ),
        ),
      ),
    );
  }
}
