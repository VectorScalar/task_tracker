import 'package:flutter/material.dart';
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
        leading: CircleAvatar(backgroundColor: taskCollection.idColor, child: Text(taskCollection.abreviatedName)),
        title: Text(taskCollection.title),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Todo
            Row(
              children: [
                const Icon(Icons.check_box_outlined),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.todo).length}")
              ],
            ),
            //In Progress
             Row(
              children: [
                const Icon(Icons.run_circle_outlined,),
                Text(": ${taskCollection.tasks.where((task) => task.taskState == TaskState.inProgress).length}")
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
            ],),
          trailing: Transform(
            transform: Matrix4.rotationZ(.5),
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(Icons.push_pin_outlined),
              iconSize: 15,
              
              selectedIcon: const Icon(Icons.push_pin),
              onPressed: (){},
              ),
          ),
          onTap: () => onOpenTaskCollection(),
      ),
    );
    
  }
}