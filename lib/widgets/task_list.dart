import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_item.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.taskCollection, required this.onRemoveTask});

  final TaskCollection taskCollection;
  final void Function(Task task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: taskCollection.tasks.length,
        itemBuilder: (ctx, index) => TaskItem(taskCollection.tasks[index]));
  }
}