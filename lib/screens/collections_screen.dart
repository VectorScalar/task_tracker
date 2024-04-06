import 'package:flutter/material.dart';
import 'package:task_tracker/data/task_collections.dart';
import 'package:task_tracker/models/screen.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_collection_list.dart';
import 'package:task_tracker/widgets/task_list.dart';
import 'package:task_tracker/models/task.dart';

///Summary
///Screen to be used for displaying tasks that are active throughout all collections and can be filtered


class CollectionScreen extends Screen {
  const CollectionScreen(super.title, {super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {


  @override
  Widget build(BuildContext context) {
    return TaskCollectionList(collections: taskCollections, onRemoveCollection: (collection){});
  }
}