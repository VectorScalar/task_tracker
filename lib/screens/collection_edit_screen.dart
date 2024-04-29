import 'package:flutter/material.dart';
import 'package:task_tracker/models/confirm_input_manager.dart';
import 'package:task_tracker/models/task.dart';
import 'package:task_tracker/models/task_collection.dart';
import 'package:task_tracker/widgets/confirm_input_bar.dart';
import 'package:task_tracker/widgets/formfield_withconfir.dart';
import 'package:task_tracker/widgets/task_item.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();




class CollectionEditScreen extends StatefulWidget {
  const CollectionEditScreen(
      {super.key,
      required this.taskCollection,
      required this.onEditCollection});

  final TaskCollection taskCollection;
  final Function(TaskCollection taskCollection) onEditCollection;

  @override
  State<CollectionEditScreen> createState() {
    return _CollectionEditScreen();
  }
}

class _CollectionEditScreen extends State<CollectionEditScreen> {
  final stateTitles = states.values.toList();
  final stateValues = states.keys.toList();
  final TextEditingController titleEditController = TextEditingController();
  final TextEditingController descEditController = TextEditingController();
  
  final ConfirmInputManager inputManager = ConfirmInputManager(scaffoldKey);

  

  @override
  void dispose() {
    titleEditController.dispose();
    descEditController.dispose();
    super.dispose();
  }

  void _modifyTask(Task task) {
    if (widget.taskCollection.tasks.contains(task)) {
      setState(() {
        widget.taskCollection.tasks[widget.taskCollection.tasks.indexOf(task)] =
            task;
        widget.onEditCollection(widget.taskCollection);
      });
    }
  }

  saveTitleField(String value) {
    if (value.trim().isNotEmpty) {
      widget.taskCollection.title = value;
      widget.onEditCollection(widget.taskCollection);
    } else {
      titleEditController.text = widget.taskCollection.title;
    }
  }

  saveDescField(String value) {
    if (value.trim().isNotEmpty) {
      widget.taskCollection.desc = value;
    } else {
      descEditController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    descEditController.text = widget.taskCollection.desc;
    titleEditController.text = widget.taskCollection.title;

    Widget content = ListView.builder(
        itemCount: states.length + 1,
        itemBuilder: (BuildContext context, index) {
          return index == 0
              ? Container(
                  margin: const EdgeInsets.all(10),
                  child: FormFieldWithConfirm(
                    initialValue: widget.taskCollection.desc, 
                    onValueSaved: (newDesc){widget.taskCollection.desc = newDesc;},
                    inputManager: inputManager,
                    maxLines: null,
                    minLines: 3,
                    decoration: InputDecoration().copyWith(
                      hintText: "....Add Description"
                    )
                  )
                )
              : ExpansionTile(
                  key: PageStorageKey(stateTitles[index - 1].stateName),
                  initiallyExpanded: true,
                  title: Text(stateTitles[index - 1].stateName),
                  children: widget.taskCollection.tasks
                      .map((t) => TaskItem(
                            key: ValueKey(t.id),
                            task: t,
                            onModifyTask: _modifyTask,
                          ))
                      .toList()
                      .where((taskItem) =>
                          taskItem.task.taskState == stateValues[index - 1])
                      .toList());
        });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:
             FormFieldWithConfirm(
              validator: (p0) {
                if(p0!.length <= 1){
                  return "Minimum of 1 char";
                } else{
                  return null;
                }
              },
              style: Theme.of(context).textTheme.titleLarge,
              decoration: const InputDecoration()
              .copyWith(isDense: true, enabledBorder: InputBorder.none),
              initialValue: widget.taskCollection.title, 
              inputManager: inputManager,
              onValueSaved: (newTitle){
                widget.taskCollection.title = newTitle;
                widget.onEditCollection(widget.taskCollection);
                },),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: content,
    );
  }
}
