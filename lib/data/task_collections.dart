import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

final taskCollections = [
  TaskCollection(
    idColor: Colors.red,
    tasks: [
      Task.unscheduledDate(title: "Task",)
    ], 
    title: "Collection"),
    TaskCollection(
    idColor: Colors.purple,
    tasks: [
      Task.unscheduledDate(title: "Task 1")
    ], 
    title: "Collection 1")
];