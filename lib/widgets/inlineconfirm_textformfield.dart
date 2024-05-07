import 'package:flutter/material.dart';


class InlineTextFormField extends StatefulWidget{
  const InlineTextFormField({super.key, this.initialValue = ""});

  final String initialValue;

  @override
  State<InlineTextFormField> createState() {
    // TODO: implement createState
    return _InlineTextFormFieldState();
  }
}

class _InlineTextFormFieldState extends State<InlineTextFormField>{
   final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  bool showButtons = false;
  String currentValue = "";
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    textController.text = widget.initialValue;
    currentValue = textController.text;
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  void validateInput(){
    setState(() {
      if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
    } else{
      _formKey.currentState!.reset();
    }
    
    focusNode.unfocus();
    showButtons = false;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    textController.text = currentValue;
    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if(showButtons) IconButton(padding: EdgeInsets.zero,
          onPressed: (){
            setState(() {
              showButtons = false;
              focusNode.unfocus();
            });
          },
          icon: Icon(Icons.close)),
        Expanded(
          child: Focus(
          focusNode: focusNode,
          onFocusChange: (hasFocus){
            if(hasFocus){
              setState(() {
                showButtons = true;
              });
            } 
          },
          child: TextFormField(
            //onTapOutside: (event){focusNode.unfocus();},
            controller: textController,
            key: _formKey,
             validator: (p0) {
                if(p0!.isEmpty){
                  return "Minimum of 1 char";
                } else{
                  return null;
                }
              },
            onSaved: (newValue){
           
                currentValue = newValue!;
            
         
              
            },
            onFieldSubmitted: (value) {
            validateInput();
            },
            
          ),
        )),
        // if(showButtons)
        // IconButton(onPressed: (){validateInput();}, icon: Icon(Icons.check))
    ],);
  }
}