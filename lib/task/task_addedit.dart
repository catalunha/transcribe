import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/widget/input_checkbox.dart';
import 'package:transcribe/widget/input_title.dart';
import 'package:transcribe/widget/required_inform.dart';
import 'package:transcribe/search_phrase/search_phrase.dart';
import 'package:transcribe/search_team/search_team.dart';

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
  _TaskAddEditState createState() => _TaskAddEditState();
}

class _TaskAddEditState extends State<TaskAddEdit> {
  late FormControllerTask formControllerTask;

  @override
  void initState() {
    super.initState();
    formControllerTask = widget.formControllerTask;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task.'),
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
                isFieldValid: widget.formControllerTask.isTeamValid,
              ),
              SearchPhrase(
                label: 'Select phrase for this task',
                phrase: widget.formControllerTask.taskModel.phrase,
                required: true,
                isFieldValid: widget.formControllerTask.isPhraseValid,
              ),
              InputCheckBox(
                title: 'Write the sentence instead of ordering',
                subtitle:
                    'if checked. student must write the sentence. not ordering.',
                icon: AppIconData.check,
                value: formControllerTask.taskModel.isWritten,
                onChanged: (value) {
                  formControllerTask.onChange(isWritten: value);
                  setState(() {});
                },
              ),
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
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          setState(() {});
          formControllerTask.onCheckValidation();
          widget.formControllerTask.onFieldExtraValidation();
          if (formControllerTask.isFormValid &&
              widget.formControllerTask.isFieldsExtraValid) {
            Navigator.pop(context);
            widget.onSave(formControllerTask.taskModel);
          }
        },
      ),
    );
  }
}
