
import 'package:flutter/material.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_item.dart';

class CollectionEditScreen extends StatefulWidget {
  const CollectionEditScreen({super.key, required this.taskCollection, required this.onEditCollection});

  final TaskCollection taskCollection;
  final Function(TaskCollection taskCollection) onEditCollection;

  @override
  State<CollectionEditScreen> createState() {

    return _CollectionEditScreen();
  }
}


class _CollectionEditScreen extends State<CollectionEditScreen> {
  var stateTitles = states.values.toList();
  var stateValues = states.keys.toList();

  void _modifyTask(Task task){
    if(widget.taskCollection.tasks.contains(task)){
      setState(() {
        widget.taskCollection.tasks[widget.taskCollection.tasks.indexOf(task)] = task;
        widget.onEditCollection(widget.taskCollection);
      });
   
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
            itemCount: states.length,
            itemBuilder: (BuildContext context, index){
            return ExpansionTile(
              initiallyExpanded: true,
              title: Text(stateTitles[index].stateName), 
              children: widget.taskCollection.tasks.map((t) => TaskItem(
                key: ValueKey(t.id),
                task: t,
                onModifyTask: _modifyTask,)).toList().where((taskItem) => taskItem.task.taskState == stateValues[index]).toList());
          }
          
          );


    return Scaffold(
      //TODO: Change appbar text to an input field to allow for editing of collection name
      appBar: AppBar(
        title: Text(widget.taskCollection.title),
        ),
      body: content,
      
    );
  }
}
