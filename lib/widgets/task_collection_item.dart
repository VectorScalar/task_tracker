import 'package:flutter/material.dart';
import 'package:task_tracker/main.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

class TaskCollectionItem extends StatelessWidget {
  
  //Will likely need a listender to listen for changes in the taask
  const TaskCollectionItem({super.key, required this.taskCollection, required this.onOpenTaskCollection});
  final TaskCollection taskCollection;
  final void Function() onOpenTaskCollection;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        titleTextStyle: Theme.of(context).textTheme.labelLarge,
        leading: CircleAvatar(backgroundColor: taskCollection.idColor, child: Text(taskCollection.abreviatedName)),
        title: Text(taskCollection.title),
        subtitle: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             //In Progress
             Row(
              children: [
                const Icon(Icons.run_circle_outlined,),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.inProgress).length}")
              ],
            ),
            //Todo
            Row(
              children: [
                const Icon(Icons.check_box_outline_blank_rounded),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.todo).length}")
              ],
            ),
           
            //Completed
             Row(
              children: [
                const Icon(Icons.check_box_outlined,),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.completed).length}")
              ],
            ),
            //Scheduled
             Row(
              children: [
                const Icon(Icons.schedule_outlined,),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.scheduled).length}"),
              ],
            ),
            //Spacer(flex: 0),
                    Transform(
            transform: Matrix4.rotationZ(.5),
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.push_pin_outlined),
              selectedIcon: const Icon(Icons.push_pin),
              onPressed: (){},
              ),
          ),
            ],),
         
          onTap: () => onOpenTaskCollection(),
      ),
    );
    
  }
}