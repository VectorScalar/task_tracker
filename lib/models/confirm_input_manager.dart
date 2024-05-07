import 'package:flutter/material.dart';
import 'package:task_tracker/widgets/confirm_input_bar.dart';

class ConfirmInputManager{
  ConfirmInputManager(this.scaffoldKey);
  GlobalKey<ScaffoldState> scaffoldKey;
  bool _isOpen = false;


  final List<ConfirmInputData> inputs = [];
  final List<ConfirmInputData> activeInputs = [];
  late ConfirmInputData currentInput;
  late PersistentBottomSheetController controller;

  void onSubmit(){
    if(currentInput.formKey.currentState!.validate())
    {
      currentInput.formKey.currentState!.save();
      
    } else {
      currentInput.formKey.currentState!.reset();}

    closeModal();
  }

  void registerInput(GlobalKey<FormFieldState> formKey, FocusNode focusNode){
    ConfirmInputData newInputData = ConfirmInputData(formKey: formKey, focusNode: focusNode);
    inputs.add(newInputData);
    focusNode.addListener(onFocusChanged);
  }

  void unRegisterInput(GlobalKey<FormFieldState> formKey, FocusNode focusNode){
    inputs.removeWhere((input) => input.formKey == formKey);
    focusNode.removeListener(onFocusChanged);
  }

  void onFocusChanged(){
    List<ConfirmInputData> noFocus = [];

    for(int i = 0; i < inputs.length; i++){
      if(inputs[i].focusNode.hasFocus){
        if(!_isOpen){
          controller = scaffoldKey.currentState!.showBottomSheet((context) => ConfirmInputBar(onSubmit: onSubmit, onCancel: onCancel), enableDrag: false);
          _isOpen = true;
          currentInput = inputs[i];
        } else{
          currentInput.formKey.currentState!.reset();
          currentInput = inputs[i];
        }

        
      } 
      //If the input doesnt have focus
      else {
        noFocus.add(inputs[i]);
      }
    }

    if(noFocus.length == inputs.length){
      closeModal();
    } else{
      noFocus.clear();
    }

  }

  void onCancel(){
    currentInput.formKey.currentState!.reset();
    
    closeModal();
  }


  void closeModal(){
    if(_isOpen){
        currentInput.focusNode.unfocus();
        //currentInput.focusNode.unfocus();
        controller.close();
        _isOpen = false;
    }
  }

  
}


class ConfirmInputData{
  const ConfirmInputData({required this.formKey, required this.focusNode});

  final GlobalKey<FormFieldState> formKey;
  final FocusNode focusNode;

}