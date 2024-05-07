
import 'package:flutter/material.dart';

class ConfirmInputBar extends StatelessWidget{
  const ConfirmInputBar({super.key, required this.onSubmit, required this.onCancel});

  final void Function() onSubmit;
  final void Function() onCancel;
   

  @override
  Widget build(BuildContext context) {

    //If this widget is popped i want the inputfield to lose focus
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
        color: Theme.of(context).cardColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(onPressed: (){
            //Navigator.pop(context);
            onCancel();},
            icon: const Icon(Icons.close, color: Colors.red,)), 
          IconButton(onPressed: (){
            //Navigator.pop(context);
            
            onSubmit();}, 
          icon: const Icon(Icons.check, color: Colors.lightGreen,))],),
    );
  }
}
