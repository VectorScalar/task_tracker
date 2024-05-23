import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_tracker/models/task.dart';

class TaskProgressTile extends StatefulWidget {
  const TaskProgressTile(
      {super.key, required this.context, required this.taskProgress, required this.onProgressChanged});

  final BuildContext context;
  final TaskProgress taskProgress;
  final Function(TaskProgress) onProgressChanged;
  @override
  State<TaskProgressTile> createState() {
    return _TaskProgressTileState();
  }
}

class _TaskProgressTileState extends State<TaskProgressTile> {
  TextEditingController currentProgressController = TextEditingController();
  TextEditingController progressGoalController = TextEditingController();

  @override
  void dispose() {
    currentProgressController.dispose();
    progressGoalController.dispose();
    super.dispose();
  }

  List<TextInputFormatter> numsWithDecimalInputFormatter() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      TextInputFormatter.withFunction((oldValue, newValue) {
        final text = newValue.text;
        var parsed = double.tryParse(text);
        if (text.isNotEmpty && parsed == null) {
          if (text == ".") {
            return newValue.replaced(
                TextRange(start: 0, end: text.length), "0.");
          } else {
            return oldValue;
          }
        } else {
          return newValue;
        }
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    currentProgressController.text =
        widget.taskProgress.currentProgress.toString();
    progressGoalController.text = widget.taskProgress.progressGoal.toString();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      title: Theme(
        data: Theme.of(context).copyWith(
            inputDecorationTheme: const InputDecorationTheme().copyWith(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        )),
        child: Container(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              //Progress Input Field With Label
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Progress",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .labelMedium!
                          .copyWith(color: Colors.black.withOpacity(.5))),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if(!hasFocus){
                        currentProgressController.text = widget.taskProgress.currentProgress.toString();
                      }
                    },
                    child: TextFormField(
                      decoration: const InputDecoration().copyWith(suffixText: widget.taskProgress.unit.unit),
                      onFieldSubmitted: (value) {
                        var doubleVal = double.tryParse(value);
                        if(doubleVal == null){
                          currentProgressController.text = widget.taskProgress.currentProgress.toString();
                        } else{
                          widget.taskProgress.currentProgress = doubleVal;
                          widget.onProgressChanged(widget.taskProgress);
                        }
                      },
                      controller: currentProgressController,
                      inputFormatters: numsWithDecimalInputFormatter(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              )),
              // Display "/" as in, "Out of"
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                  child: Text("/",
                      style: const TextStyle()
                          .copyWith(fontSize: 20, color: Colors.white))),

              // Goal Input Field With Label
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Goal",
                      style: Theme.of(context)
                          .primaryTextTheme
                          .labelMedium!
                          .copyWith(color: Colors.black.withOpacity(.5))),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if(!hasFocus){
                        progressGoalController.text = widget.taskProgress.progressGoal.toString();
                      }
                    },
                    child: TextFormField(
                      decoration: const InputDecoration().copyWith(suffixText: widget.taskProgress.unit.unit),
                      onFieldSubmitted: (value) {
                        var doubleVal = double.tryParse(value);
                        if(doubleVal == null){
                          progressGoalController.text = widget.taskProgress.progressGoal.toString();
                        } else{
                          widget.taskProgress.progressGoal = doubleVal;
                          widget.onProgressChanged(widget.taskProgress);
                        }
                      },
                      controller: progressGoalController,
                      inputFormatters: numsWithDecimalInputFormatter(),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
