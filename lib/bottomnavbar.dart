import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/pages/camera_page.dart';
import 'package:helloworld/pages/homepage.dart';
import 'package:helloworld/pages/map_Page.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      selectedItemColor: Colors.blue,
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePageWidget()),
              (route) => false,
            );
            break;
          case 1:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
              (route) => false,
            );
            break;
          case 2:
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
              (route) => false,
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: ''
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: ''
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: ''
        ),
      ],
      
    );
  
  }
    }