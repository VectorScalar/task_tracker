import 'package:flutter/material.dart';
import 'package:task_tracker/models/confirm_input_manager.dart';

class FormFieldWithConfirm extends StatefulWidget {
  FormFieldWithConfirm(
      {super.key,
      required this.onValueSaved,
      required this.inputManager,
      this.initialValue,
      this.style,
      this.validator,
      this.decoration,
      this.minLines,
      this.maxLines = 1});
  final String? initialValue;
  final Function(String newValue) onValueSaved;
  final ConfirmInputManager inputManager;

  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final TextStyle? style;
  final int? maxLines, minLines;
  @override
  State<FormFieldWithConfirm> createState() {
    return _FormFieldWithConfirmState();
  }
}

class _FormFieldWithConfirmState extends State<FormFieldWithConfirm> {
  final TextEditingController _controller = TextEditingController();
  // late PersistentBottomSheetController controller;
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();
  final FocusNode focusNode = FocusNode();
  bool open = false;
  String currentValue = "";

  @override
  void initState() {
    _controller.text = widget.initialValue ?? "";
    currentValue = _controller.text;
    widget.inputManager.registerInput(_formKey, focusNode);
    super.initState();
  }

  @override
  void dispose() {
    widget.inputManager.unRegisterInput(_formKey, focusNode);
    focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = currentValue;
    return Focus(
      focusNode: focusNode,
      // onFocusChange: (gainedFocus){

      //   if(gainedFocus){

      //       widget.inputManager.openModal(ConfirmInputData(formKey: _formKey, focusNode: focusNode));
      //   }

      //   // if(!gainedFocus){
      //   //   widget.inputManager.onLostFocus(_formKey);
      //   //   _controller.text = currentValue;
      //   // }
      // },
      child: TextFormField(
          key: _formKey,
          style: widget.style,
          controller: _controller,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          onFieldSubmitted: (value) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
            } else {
              _formKey.currentState!.reset();
            }
          },
          onSaved: (value) {
            setState(() {
              currentValue = value!;
              widget.onValueSaved(value);
            });

            // widget.inputManager.closeModal();
          },
          decoration: widget.decoration,
          validator: widget.validator),
    );
  }
}
