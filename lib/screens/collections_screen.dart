import 'package:flutter/material.dart';
import 'package:task_tracker/data/collection_data.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_collection_item.dart';
import 'package:task_tracker/screens/collection_edit_screen.dart';


///Summary
///Screen to be used for displaying tasks that are active throughout all collections and can be filtered




class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() {
    return _CollectionsScreenState();
}}

  class _CollectionsScreenState extends State<CollectionsScreen>{
  void _openCollectionEditScreen(BuildContext context, TaskCollection collection){
    Navigator.of(context).push(MaterialPageRoute(builder: ((ctx) => CollectionEditScreen(taskCollection: collection, onEditCollection: _editCollection,)),));
  }

    void _editCollection(TaskCollection taskCollection){
    setState(() {
      if(collectionData.contains(taskCollection)){
      var collIndex = collectionData.indexOf(taskCollection);
      collectionData[collIndex] = taskCollection;
      } else{
        throw Exception("Attempting to edit collection that dosen't exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var collections = collectionData;
    return ListView.builder(
        itemCount: collections.length,
        itemBuilder: (ctx, index) => TaskCollectionItem(
          taskCollection: collections[index],
          onOpenTaskCollection: (){
            _openCollectionEditScreen(context, collections[index]);
          }),
        );
  }

}