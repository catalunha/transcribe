import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../task_addedit.dart';
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
      onDispose: (store) {
        store.dispatch(SetNulTaskCurrentTaskAction());
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
          dispatch(AddDocTaskAction(taskModel: taskModelTemp));
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
  bool isFieldsExtraValid = false;
  bool? isTeamValid;
  bool? isPhraseValid;

  TaskModel taskModel;
  FormControllerTask({
    required this.taskModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;
  void onChange({
    String? name,
    bool? isArchived,
    bool? isDeleted,
  }) {
    taskModel = taskModel.copyWith(
      title: name,
      isArchived: isArchived,
      isDeleted: isDeleted,
    );
  }

  onFieldExtraValidation() {
    if (taskModel.team != null) {
      isTeamValid = true;
    } else {
      isTeamValid = false;
    }
    if (taskModel.phrase != null) {
      isPhraseValid = true;
    } else {
      isPhraseValid = false;
    }
    isFieldsExtraValid = (isTeamValid ?? false) && (isPhraseValid ?? false);
  }

  void onCheckValidation() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
