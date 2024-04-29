
import 'package:flutter/material.dart';
import 'package:task_tracker/widgets/tracker.dart';

void main() {
  runApp(
    const MainApp()
    );
}
//ColorScheme myscheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme myscheme = ColorScheme.fromSeed(
      seedColor: const Color.fromRGBO(0, 155, 209, 1),
  //    brightness: MediaQuery.platformBrightnessOf(context)
      );


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: myscheme,
        
          //  appBarTheme: const AppBarTheme().copyWith(
          // backgroundColor: myscheme.primary,
          // foregroundColor: myscheme.onPrimary,
          // surfaceTintColor: myscheme.surfaceTint,
          // ),
        expansionTileTheme: const ExpansionTileThemeData().copyWith(
          
          backgroundColor: myscheme.tertiary,
          
          textColor: myscheme.onTertiary,
          collapsedTextColor: myscheme.onTertiary,
          iconColor: myscheme.onTertiary,
          collapsedIconColor: myscheme.onTertiary,
          //tilePadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
          collapsedBackgroundColor: myscheme.tertiary,
          
        ),

         cardTheme: const CardTheme().copyWith(
          shape: const ContinuousRectangleBorder(),
          elevation: 0,
          surfaceTintColor: myscheme.surfaceTint,
          margin: const EdgeInsets.only(top: 0, bottom: 0)
          
      ),
        /*
        checkboxTheme: CheckboxThemeData().copyWith(
          fillColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
            if(states.contains(MaterialState.selected))
            {
              return myscheme.tertiary;
            } else {
              return myscheme.surface;
            }
          })
        ),
        //dividerColor: myscheme.secondaryContainer,
        scaffoldBackgroundColor: myscheme.background,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: myscheme.primary,
          foregroundColor: myscheme.onPrimary,
          surfaceTintColor: myscheme.surfaceTint,
          ),
         
          
           
            //filled: true,
            //fillColor: myscheme.surface,
        

    
          
        navigationBarTheme: const NavigationBarThemeData().copyWith(
          indicatorColor: myscheme.primaryContainer,
          elevation: 2,
          surfaceTintColor: myscheme.surfaceTint,
          shadowColor: Colors.black,
         
        ),

        sliderTheme: const SliderThemeData().copyWith(
            showValueIndicator: ShowValueIndicator.always,
            activeTrackColor: myscheme.primary,
            
            thumbColor: myscheme.primary
        ),

        iconTheme: const IconThemeData().copyWith(
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
          surfaceTintColor: myscheme.surfaceTint,
          margin: const EdgeInsets.only(top: 0, bottom: 0)
          */
      //)
      )
        
      ,
      home: const Tracker()
    );
  }
}
