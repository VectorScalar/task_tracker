import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/task_list.dart';

class TaskCollectionModal extends StatefulWidget {
  const TaskCollectionModal({super.key, required this.taskCollection});

  final TaskCollection taskCollection;

  @override
  State<StatefulWidget> createState() {

    return _OpenTaskCollectionModal();
  }
}

class _OpenTaskCollectionModal extends State<TaskCollectionModal> {
  @override
  Widget build(BuildContext context) {

    return Column(children: [
      Container(
          padding: const EdgeInsets.all(20),
          //decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          child: TextFormField(
            decoration: const InputDecoration().copyWith(
              enabledBorder: InputBorder.none,
              //suffixIcon: Icon(Icons.edit)
            ),
            textAlign: TextAlign.center,
            initialValue: widget.taskCollection.title,
            style: const TextStyle()
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          )),
      
      Expanded(
        child: Container(
          color: Theme.of(context).colorScheme.secondary,
          child: TaskList(taskCollection: widget.taskCollection, onRemoveTask: (task) {})),
      )
    ]);
  }
}
