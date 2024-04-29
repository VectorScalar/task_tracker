import 'package:flutter/material.dart';
import 'package:task_tracker/widgets/confirm_input_bar.dart';

class ConfirmInputManager{
  ConfirmInputManager(this.scaffoldKey);
  
  GlobalKey<ScaffoldState> scaffoldKey;
  bool _isOpen = false;


  final List<GlobalKey<FormFieldState>> fields = [];
  late GlobalKey<FormFieldState> currentField;
  late PersistentBottomSheetController controller;

  void onSubmit(){
    if(currentField.currentState!.validate())
    {
      currentField.currentState!.save();
    } else {
      currentField.currentState!.reset();}

    closeModal();
  }

  void onLostFocus(GlobalKey<FormFieldState> formKey){
    if(formKey == currentField){
      closeModal();
    }
  }

  void onCancel(){
    currentField.currentState!.reset();
    
    closeModal();
  }

  void openModal(GlobalKey<FormFieldState> formKey){
  
    if(!_isOpen){
      controller = scaffoldKey.currentState!.showBottomSheet((context) => ConfirmInputBar(onSubmit: onSubmit, onCancel: onCancel), enableDrag: false);
      controller.closed.then((value) => _isOpen = false);
      _isOpen = true;
      currentField = formKey;

      
    } 
    //if already open dont reopen the modal
    else {
      //atttempting to open from other field
        currentField = formKey;
    }
    
    
  }

  void closeModal(){
    if(_isOpen){
        controller.close();
    }
  }

  
}