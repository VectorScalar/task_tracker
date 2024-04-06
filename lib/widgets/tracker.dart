import 'package:flutter/material.dart';
import 'package:task_tracker/models/screen.dart';
import 'package:task_tracker/screens/collections_screen.dart';
import 'package:task_tracker/screens/overview_screen.dart';
import 'package:task_tracker/widgets/bottom_navbar.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  int currentPageIndex = 0;

  List<Screen> screens = [
    const CollectionScreen("Collections"),
    const OverviewScreen("Overview"),
    const OverviewScreen("Unnamed"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(screens[currentPageIndex].title)),
        body: screens[currentPageIndex],
        bottomNavigationBar: BottomNavBar(onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        }),
        
    );
  }
}
