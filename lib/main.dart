
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
         
            
           
            //filled: true,
            //fillColor: myscheme.surface,
        expansionTileTheme: ExpansionTileThemeData().copyWith(
          backgroundColor: myscheme.primary,
          textColor: myscheme.onPrimary,
          collapsedTextColor: myscheme.onPrimary,
          iconColor: myscheme.onPrimary,
          collapsedIconColor: myscheme.onPrimary,
          tilePadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          collapsedBackgroundColor: myscheme.primary,
          
        ),
        
          
        navigationBarTheme: const NavigationBarThemeData().copyWith(
          indicatorColor: myscheme.primaryContainer,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
         
        ),

        sliderTheme: SliderThemeData().copyWith(
            showValueIndicator: ShowValueIndicator.always
        ),

        iconTheme: IconThemeData().copyWith(
          color: myscheme.primary
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: myscheme.primary
          )
        ),
        cardTheme: const CardTheme().copyWith(
          shape: const ContinuousRectangleBorder(),
          elevation: 0,
          margin: const EdgeInsets.only(top: 0, bottom: 0)
        )
      )
        
      ,
      home: const Tracker()
    );
  }
}
