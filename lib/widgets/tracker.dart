import 'package:flutter/material.dart';
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


   final screens = {
    "Collections" : const CollectionsScreen(),
    "Overview" :const OverviewScreen(),
    "No Se" : const OverviewScreen(),
   };
  @override
  Widget build(BuildContext context) {
    var titles = screens.keys.toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(titles[currentPageIndex])),
        body: screens[titles[currentPageIndex]],
        bottomNavigationBar: BottomNavBar(onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        }),
        
    );
  }
}
