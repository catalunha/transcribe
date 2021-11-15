import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/widget/input_checkbox.dart';
import 'package:transcribe/widget/input_checkbox_delete.dart';
import 'package:transcribe/widget/input_title.dart';
import 'package:transcribe/widget/input_users.dart';
import 'package:transcribe/widget/required_inform.dart';
import 'package:transcribe/widget/search_phrase.dart';
import 'package:transcribe/widget/search_team.dart';

import 'controller/task_addedit_connector.dart';
import 'controller/task_model.dart';

class TaskAddEdit extends StatefulWidget {
  final FormControllerTask formControllerTask;
  final Function(TaskModel) onSave;

  const TaskAddEdit({
    Key? key,
    required this.formControllerTask,
    required this.onSave,
  }) : super(key: key);

  @override
  _TaskAddEditState createState() => _TaskAddEditState(formControllerTask);
}

class _TaskAddEditState extends State<TaskAddEdit> {
  final FormControllerTask formControllerTask;

  _TaskAddEditState(this.formControllerTask);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task.'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formControllerTask.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTitle(
                label: 'Name for the task',
                required: true,
                initialValue: formControllerTask.taskModel.title,
                validator: formControllerTask.validateRequiredText,
                onChanged: (value) {
                  formControllerTask.onChange(name: value);
                },
              ),
              SearchTeam(
                label: 'Select team for this task',
                team: widget.formControllerTask.taskModel.team,
                required: true,
              ),
              SearchPhrase(
                label: 'Select phrase for this task',
                phrase: widget.formControllerTask.taskModel.phrase,
                required: true,
              ),
              // formControllerTask.taskModel.id.isEmpty
              //     ? Container()
              //     : InputCheckBox(
              //         title: 'Archived this task',
              //         subtitle: 'Select to archive this task.',
              //         icon: AppIconData.inbox,
              //         value: formControllerTask.taskModel.isArchived,
              //         onChanged: (value) {
              //           formControllerTask.onChange(isArchived: value);
              //           setState(() {});
              //         },
              //       ),
              // formControllerTask.taskModel.id.isEmpty
              //     ? Container()
              //     : InputCheckBoxDelete(
              //         title: 'Delete this task',
              //         subtitle: 'Delete forever',
              //         value: formControllerTask.taskModel.isDeleted,
              //         onChanged: (value) {
              //           formControllerTask.onChange(isDeleted: value);
              //           setState(() {});
              //         },
              //       ),
              RequiredInForm(
                message: 'task id: ${formControllerTask.taskModel.id}',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this data in cloud',
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          formControllerTask.onCheckValidation();
          if (formControllerTask.isFormValid) {
            Navigator.pop(context);
            widget.onSave(formControllerTask.taskModel);
          }
        },
      ),
    );
  }
}
