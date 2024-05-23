import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_edit_widgets/taskedit_expansiontile.dart';

class TaskEditScreen extends StatefulWidget {
  const TaskEditScreen.editTask(
      {super.key, required this.task, required this.initialCollection});
  TaskEditScreen.newTask({super.key, required this.initialCollection})
      : task = Task();
  final Task task;

  final TaskCollection initialCollection;

  @override
  State<TaskEditScreen> createState() {
    return _TaskEditScreenState();
  }
}

//TODO: Add support for changing intended taskcollection
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
  Widget datePickerButton() {
    return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        label: const Text(""),
        onPressed: () async {
          await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)))
              .then((value) {
            widget.task.scheduledDate = value;
            //print(value);
          });
        },
        icon: const Icon(Icons.schedule));
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

  DropdownMenu<Priority> _taskPriorityDropDown() {
    return DropdownMenu<Priority>(
        textStyle: const TextStyle(color: Colors.transparent),
        leadingIcon: widget.task.priority.priorityIcon,
        width: 120,
        enableSearch: false,
        initialSelection: widget.task.priority,
        onSelected: (value) => setState(() {
              widget.task.priority = value!;
            }),
        dropdownMenuEntries:
            Priority.values.map<DropdownMenuEntry<Priority>>((entry) {
          return DropdownMenuEntry<Priority>(
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              value: entry,
              label: entry.priorityName,
              trailingIcon: entry.priorityIcon);
          //labelWidget: entry.priorityIcon);
        }).toList());
  }

  DropdownMenu<TaskState> _taskStateDropDown() {
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
    return Column(
      children: [
        const SizedBox(height: 5,),
        //Title text form field
        Row(
          children: [
            IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.close)),
            Expanded(
              child: TextFormField(
                controller: _titleController,
                onFieldSubmitted: (value){
                  if(value.isEmpty)
                  {
                    _titleController.text = widget.task.title;
                  } else{
                    widget.task.title = value;
                  }
                  },
                
              ), 
            ),
            const SizedBox(width: 40,)
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    //TODO Work on actually implementing scheduling
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Task State"),
                        _taskStateDropDown(),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Priority"),
                        _taskPriorityDropDown(),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Progress Trackers"),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.task.taskProgressables.add(TaskProgress());
                          });
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.task.taskProgressables.length,
                    itemBuilder: (context, index) {
                      return TaskEditExpansionTile(
                        key: ValueKey(widget.task.taskProgressables[index].id),
                        taskProgress: widget.task.taskProgressables[index],
                        onValueChanged: (taskProgress) {
                          widget.task.taskProgressables[index] = taskProgress;
                        },
                        onDeleteTile: () {
                          setState(() {
                            widget.task.taskProgressables.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                FilledButton(onPressed: (){
                  Navigator.pop(context, widget.task);
                }, child: SizedBox(width: MediaQuery.sizeOf(context).width,child: const Text("Save", textAlign: TextAlign.center,))),
                const SizedBox(height: 10,)
              ],
            ),
          ),
        ),
        
        
        
      ],
    );
  }
}
