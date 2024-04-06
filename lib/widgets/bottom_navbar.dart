import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onDestinationSelected});
  
  final Function(int) onDestinationSelected;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        onDestinationSelected: (int index){
          currentPageIndex = index;
          widget.onDestinationSelected(index);
        },
        selectedIndex: currentPageIndex,
          destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed_sharp),
            label: 'Collections',
          ),
          NavigationDestination(
            icon: Icon(Icons.margin_outlined),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              isLabelVisible: false,
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      );
  }
}