import 'package:flutter/material.dart';
import 'package:task_tracker/models/screen.dart';

///Summary
///Screen to be used for displaying tasks that are active throughout all collections and can be filtered


class OverviewScreen extends Screen {
  const OverviewScreen(super.title, {super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    //return TaskList(tasks: taskCollection.map((collection) => tasks.add(...collection.tasks.)), onRemoveTask: onRemoveTask (task) {});
    //return TaskList(tasks: registeredTasks, onRemoveTask: (task) => {});
  }
}