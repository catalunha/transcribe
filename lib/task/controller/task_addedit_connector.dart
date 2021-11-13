import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../task_addedit.dart';
import '../task_addedit.dart';
import 'task_action.dart';
import 'task_action.dart';

class TaskAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const TaskAddEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskAddEditVm>(
      onInit: (store) {
        store.dispatch(SetTaskCurrentTaskAction(id: addOrEditId));
      },
      vm: () => TaskAddEditFactory(this),
      builder: (context, vm) => TaskAddEdit(
        formControllerTask: vm.formControllerTask,
        onSave: vm.onSave,
      ),
    );
  }
}

class TaskAddEditFactory extends VmFactory<AppState, TaskAddEditConnector> {
  TaskAddEditFactory(widget) : super(widget);
  @override
  TaskAddEditVm fromStore() => TaskAddEditVm(
        formControllerTask:
            FormControllerTask(taskModel: state.taskState.taskCurrent!),
        onSave: (TaskModel taskModel) {
          TaskModel taskModelTemp = taskModel.copyWith(
            team: state.taskState.taskCurrent!.team,
            phrase: state.taskState.taskCurrent!.phrase,
          );
          if (widget!.addOrEditId.isEmpty) {
            dispatch(AddDocTaskAction(taskModel: taskModelTemp));
          } else {
            dispatch(UpdateDocTaskAction(taskModel: taskModelTemp));
          }
        },
      );
}

class TaskAddEditVm extends Vm {
  final FormControllerTask formControllerTask;
  final Function(TaskModel) onSave;

  TaskAddEditVm({
    required this.formControllerTask,
    required this.onSave,
  }) : super(equals: [
          formControllerTask,
        ]);
}

class FormControllerTask {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  TaskModel taskModel;
  FormControllerTask({
    required this.taskModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;
  void onChange({
    String? name,
    bool? isArchivedByTeacher,
    bool? isDeleted,
  }) {
    taskModel = taskModel.copyWith(
      name: name,
      isArchivedByTeacher: isArchivedByTeacher,
      isDeleted: isDeleted,
    );
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
