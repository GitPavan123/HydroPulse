import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:reservoir_startuptn/Screens/Main_UI/UI_Components_Technician/settings_technician.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../UI_Components_User/Drawer_User/water_bill_user.dart';
import 'Drawer_Technician/new_connection_Technician.dart';
import 'Drawer_Technician/yearly_maintenance_technician.dart';
import 'map_ui_technician.dart';
import 'notice_technician.dart';

class NavBarTechnician extends StatefulWidget {
  final String email;

  NavBarTechnician({required this.email});
  @override
  _NavBarTechnicianState createState() => _NavBarTechnicianState();
}

class _NavBarTechnicianState extends State<NavBarTechnician> {
  int selectedItem = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          _getPage(selectedItem),
          Positioned(
            top: 40,
            left: 12,
            child: _buildOptionsButton(context),
          ),
          Positioned(
            bottom: 18,
            left: 60,
            right: 60,
            height: 60,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ClipPath(
                  clipper: MyCustomClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
                    child: Container(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 22,
            right: 22,
            height: 86,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildBNBItem(Icons.map_outlined, 0),
                _buildBNBItem(Icons.announcement_outlined, 1),
                _buildBNBItem(Icons.settings_outlined, 2),
              ],
            ),
          ),
        ],
      ),
      drawer: NavBarDrawer(),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return MapPageTechnician(email: widget.email);
      case 1:
        return NoticePageTechnician(email: widget.email);
      case 2:
        return SettingsPageTechnician();
      default:
        return Container();
    }
  }

  Widget _buildBNBItem(IconData icon, int index) {
    return ZoomTapAnimation(
      onTap: () {
        setState(() {
          selectedItem = index;
        });
      },
      child: Icon(
        icon,
        color: selectedItem == index ? Colors.blue : Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildOptionsButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
      ),
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        customBorder: CircleBorder(),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black38,
          ),
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(64, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class NavBarDrawer extends StatefulWidget {
  @override
  _NavBarDrawerState createState() => _NavBarDrawerState();
}

class _NavBarDrawerState extends State<NavBarDrawer> {
  String selectedService = 'Water Bill';
  String dropdownValue = 'Water Bill';
  bool servicesVisible = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF012C3F),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/login_screen/customer.png"),
                ),
                SizedBox(height: 10),
                Text(
                  'Pavan Kumar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'pavanbindhu54@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Iconsax.empty_wallet_tick),
            title: Text('Water Bill'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WaterBilltechnician()),
              );
            },
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            leading: Icon(Icons.miscellaneous_services_outlined),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Services'),
                InkWell(
                  onTap: () {
                    setState(() {
                      servicesVisible = !servicesVisible;
                    });
                  },
                  child: Icon(
                    servicesVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Column(
            children: [
              Container(
                color: Color(0xFF012B3F),
                child: Visibility(
                  visible: servicesVisible,
                  child: Column(
                    children: [
                      Text(
                        "-------------------------------------------------------------------------",
                        style: TextStyle(color: Colors.grey),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_tree_outlined),
                        title: Text('Yearly Maintenance'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    YearlyMaintenanceTechnician()),
                          );
                        },
                      ),
                      Text(
                        "-------------------------------------------------------------------------",
                        style: TextStyle(color: Colors.grey),
                      ),
                      ListTile(
                        leading: Icon(Iconsax.square_copy),
                        title: Text('Request a conneection'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewConnectionTechnician()),
                          );
                        },
                      ),
                      Text(
                        "-------------------------------------------------------------------------",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
