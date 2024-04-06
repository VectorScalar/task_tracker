import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

final taskCollections = [
  TaskCollection(
    idColor: Colors.red,
    tasks: [
      Task(title: "Sick todo task bro"),
      Task(title: "Sick inprogress task bro", initialState: TaskState.inProgress),
      Task(title: "Sick scheduled task bro", initialState: TaskState.scheduled),
      Task(title: "Sick scheduled task bro", initialState: TaskState.completed)

    ], 
    title: "Collection"),
    TaskCollection(
    idColor: Colors.purple,
    tasks: [
      //Task.scheduled(title: "Scheduled Example", scheduledDate: DateTime.now()),
      //Task.inProgress(title: "In Progress Example")
    ], 
    title: "Collection 1")
];