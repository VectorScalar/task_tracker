import 'package:flutter/material.dart';
 
abstract class Screen extends StatefulWidget{
  const Screen(this.title, {super.key});

  final String title;
    
}