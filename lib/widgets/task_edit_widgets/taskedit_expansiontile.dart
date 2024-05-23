
import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/widgets/task_edit_widgets/taskedit_tile.dart';

class TaskEditExpansionTile extends StatefulWidget{

  const TaskEditExpansionTile({super.key, required this.onDeleteTile, required this.taskProgress, required this.onValueChanged});

  final void Function() onDeleteTile;
  final void Function(TaskProgress progress) onValueChanged;
  final TaskProgress taskProgress;

  @override
  State<TaskEditExpansionTile> createState() {
    return _TaskEditExpansionTileState();
  }
}

class _TaskEditExpansionTileState extends State<TaskEditExpansionTile>{
  bool isExpanded = false;
  TextEditingController titleController = TextEditingController();

  MenuAnchor unitOptionsMenu(){
    return MenuAnchor(
      
      builder: (context, controller, child) {
        return IconButton(onPressed: (){
          if(controller.isOpen){
            controller.close();
          } else{
            controller.open();
          }
        }, icon: const Icon(Icons.straighten));
      },
      menuChildren:  UnitOption.values.map((unit){
        return MenuItemButton(
          onPressed: () => setState(() {widget.taskProgress.unit = unit;}),
          style: unit == widget.taskProgress.unit ? const ButtonStyle().copyWith(foregroundColor:MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)) : null,
           child: Text(unit.label)
          );
      }).toList()
      );
  }


  List<Widget> _expandedDisplay(){
    //return[optionsMenu()];
    return [unitOptionsMenu(), IconButton(onPressed: (){widget.onDeleteTile();}, icon: const Icon(Icons.delete))];
  }

  @override
  void initState() {
    titleController.text = widget.taskProgress.progressName;
    super.initState();
  }
  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.taskProgress.progressName;

    return ExpansionTile(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      key: widget.key,
      title: Row(children: [
         Expanded(child: Focus(
            onFocusChange: (gainedFocus) {
              if(!gainedFocus){
                titleController.text = widget.taskProgress.progressName;
              }
            },
           child: TextFormField(
              controller: titleController,
              onFieldSubmitted: (value) {
                if(titleController.text.isEmpty){
                  titleController.text = widget.taskProgress.progressName;
                } else{
                  widget.taskProgress.progressName = titleController.text;
                  widget.onValueChanged(widget.taskProgress);
                }
              },
              
              style: const TextStyle().copyWith(color: Colors.white),
              decoration: const InputDecoration().copyWith(
                enabledBorder: InputBorder.none,
                border: InputBorder.none
                //contentPadding: EdgeInsets.zero
              ),),
         ),),
        if(isExpanded)
        ..._expandedDisplay()
        ],),
      children: [
        TaskProgressTile(context: context, taskProgress: widget.taskProgress, onProgressChanged: (taskProgress) {widget.onValueChanged(taskProgress);},)
      ],
      onExpansionChanged: (value){
        setState(() {
          isExpanded = value;
        });},);
    
  }
}

