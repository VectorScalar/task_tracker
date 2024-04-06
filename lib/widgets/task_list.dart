import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/widgets/task_item.dart';
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks, required this.onRemoveTask});

  final List<Task> tasks;
  final void Function(Task task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) => TaskItem(tasks[index])),
    );
  }
}