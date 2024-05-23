import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';

final collectionData = [
  TaskCollection(
    desc: "This collection is about a bunch of stupid shit",
    idColor: Colors.red,
    tasks: [
      Task(title: "Sick todo task bro",),
      Task(title: "Sick inprogress task bro"),
      Task(title: "Sick s task bro"),
      Task(title: "Sick scheduled task bro"),
           Task(title: "Sick todo task bro",),
      Task(title: "Sick inprogress task bro"),
    ], 
    title: "Collection"),
    TaskCollection(
    desc: "This collection is a bunch of more stupid shit",
    idColor: Colors.purple,
    tasks: [
      //Task.scheduled(title: "Scheduled Example", scheduledDate: DateTime.now()),
      //Task.inProgress(title: "In Progress Example")
    ], 
    title: "Collection 1"),
];