import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

class TaskCollectionItem extends StatelessWidget {

  //Will likely need a listender to listen for changes in the taask
  const TaskCollectionItem({super.key, required this.taskCollection, required this.onOpenTaskCollection});
  final TaskCollection taskCollection;
  final Function(TaskCollection) onOpenTaskCollection;
  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: taskCollection.idColor, child: Text(taskCollection.abreviatedName)),
        title: Text(taskCollection.title),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Todo: ${taskCollection.tasks.where((task) => task.taskState == TaskState.todo).length}"),
            Text("In Progress: ${taskCollection.tasks.where((task) => task.taskState == TaskState.inProgress).length}"),
            Text("Scheduled: ${taskCollection.tasks.where((task) => task.taskState == TaskState.scheduled).length}"),
            Text("Completed: ${taskCollection.tasks.where((task) => task.taskState == TaskState.completed).length}")
          ],),
          trailing: Transform(
            transform: Matrix4.rotationZ(.5),
            alignment: Alignment.center,
            child: IconButton(
              icon: Icon(Icons.push_pin_outlined),
              iconSize: 15,
              
              selectedIcon: Icon(Icons.push_pin),
              onPressed: (){},
              ),
          ),
          onTap: () => onOpenTaskCollection(taskCollection),
      ),
    );
    
  }
}