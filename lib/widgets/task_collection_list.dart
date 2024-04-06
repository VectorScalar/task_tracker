import 'package:flutter/material.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_collection_item.dart';



class TaskCollectionList extends StatelessWidget {
  const TaskCollectionList({super.key, required this.collections, required this.onRemoveCollection, required this.onOpenCollection});

  final List<TaskCollection> collections;
  final void Function(TaskCollection task) onRemoveCollection;
    final void Function(TaskCollection collection) onOpenCollection;
  // @override
  // Widget build(BuildContext context) {
    
  
   
  // }

  @override
  Widget build(BuildContext context) {
     
    

    return Expanded(
      child: ListView.builder(
          itemCount: collections.length,
          itemBuilder: (ctx, index) => TaskCollectionItem(taskCollection: collections[index], onOpenTaskCollection: onOpenCollection,),
    ));
  }
}

