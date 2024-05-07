import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_tracker/data/collection_data.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen.editTask({super.key, required this.task, required this.taskCollection});
  TaskEditScreen.newTask({super.key, required this.taskCollection}) : task = Task();
  final Task task;
  final TaskCollection taskCollection;

  @override
  State<TaskEditScreen> createState() {
    return _TaskEditScreenState();
  }
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.task.title;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  //TODO: Implement state restoration on date picker
    Widget datePickerButton(){
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
        ),
        label: Text(""),
        onPressed: () async {
        await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)))
          .then((value){widget.task.scheduledDate = value; print(value);});
      }, icon: Icon(Icons.schedule));
    }

  // DropdownMenu<TaskCollection> _collectionsDropDown(TaskCollection taskCollection){
  //   return DropdownMenu(
  //     //label: CircleAvatar(backgroundColor: collection.idColor, child: Text(collection.abreviatedName),),
  //     width: 100,
  //     // inputDecorationTheme: InputDecorationTheme( TextStyle()),
  //     initialSelection: taskCollection,
  //     dropdownMenuEntries: 
  //       collectionData.map<DropdownMenuEntry<TaskCollection>>((collection){
  //         return DropdownMenuEntry<TaskCollection>(
  //           value: collection, 
  //           label: collection.title,

            
  //           //labelWidget: CircleAvatar(backgroundColor: collection.idColor, child: Text(collection.abreviatedName),)
  //           );
  //       }).toList()
  //     );
  // }

  DropdownMenu<Priority> _taskPriorityDropDown(){
    return DropdownMenu<Priority>(
      textStyle: const TextStyle(color: Colors.transparent),
      leadingIcon: widget.task.priority.priorityIcon,
      width: 120,
      enableSearch: false,
      initialSelection: widget.task.priority,
      onSelected: (value) => setState(() {
        widget.task.priority = value!;
      }),
      dropdownMenuEntries: Priority.values.map<DropdownMenuEntry<Priority>>((entry){
        return DropdownMenuEntry<Priority>(
          style: const ButtonStyle(
            alignment: Alignment.centerLeft),
          value: entry, 
          label: entry.priorityName,
          trailingIcon: entry.priorityIcon);
          //labelWidget: entry.priorityIcon);
          }).toList());
  
  }

  DropdownMenu<TaskState> _taskStateDropDown(){
    return DropdownMenu<TaskState>(
            enableSearch: false,
            width: 150,
            initialSelection: widget.task.taskState,
            dropdownMenuEntries:
                states.entries.map<DropdownMenuEntry<TaskState>>((entry) {
              return DropdownMenuEntry<TaskState>(
                  
                  value: entry.key,
                  label: entry.value.stateName,
                  leadingIcon: entry.value.stateIcon);
            }).toList(),
            leadingIcon: states[widget.task.taskState]!.stateIcon,
            onSelected: (value) => setState(() {
              widget.task.setState(value!);
            }),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          //Title text form field
          TextFormField(
            controller: _titleController,
          ),
          const SizedBox(height: 25,),
          Row(
            
            children: [
              //TODO Work on actually implementing scheduling
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task State"),
                  _taskStateDropDown(),
                ],
              ),
              Spacer(),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    Text("Priority"),
                     _taskPriorityDropDown(),
                   ],
                 ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Progress Trackers"),
              Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.task.taskProgress = TaskProgress();
                    });
                  },
                  icon: Icon(Icons.add))
            ],
          ),
        ],
      ),
    );
  }
}
