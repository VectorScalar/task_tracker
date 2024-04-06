import 'package:flutter/material.dart';
import 'package:task_tracker/models/task_collection.dart';

class TaskCollectionItem extends StatelessWidget {
  const TaskCollectionItem({super.key, required this.taskCollection, required this.child, required this.isCollapsable});

  final bool isCollapsable;
  final bool isCollapsed = false;
  final Widget child;
  final TaskCollection taskCollection;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundColor: taskCollection.idColor, child: Text(taskCollection.abreviatedName)),
        title: Text(taskCollection.title),
      ),
    );
    
  }
}