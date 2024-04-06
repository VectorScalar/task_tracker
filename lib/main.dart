import 'dart:html';

import 'package:flutter/material.dart';
import 'package:task_tracker/widgets/tracker.dart';

void main() {
  runApp(const MainApp());
}
ColorScheme myscheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 32, 63, 149));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: myscheme.background,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myscheme.primary,
          foregroundColor: myscheme.onPrimary,
          elevation: 20,
          ),
        navigationBarTheme: const NavigationBarThemeData().copyWith(
          indicatorColor: myscheme.primaryContainer,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
         
        ),
        cardTheme: const CardTheme().copyWith(
          shape: const ContinuousRectangleBorder(),
          elevation: 0,
          margin: const EdgeInsets.only(top: 10)
        )
      )
        
      ,
      home: const Tracker()
    );
  }
}
