import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../task_list.dart';
import 'task_action.dart';

class TaskListConnector extends StatelessWidget {
  const TaskListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVm>(
      vm: () => TaskListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTaskAction());
      },
      builder: (context, vm) => TaskList(
        taskList: vm.taskList,
      ),
    );
  }
}

class TaskListVmFactory extends VmFactory<AppState, TaskListConnector> {
  TaskListVmFactory(widget) : super(widget);
  @override
  TaskListVm fromStore() => TaskListVm(
        taskList: state.taskState.taskList!,
      );
}

class TaskListVm extends Vm {
  final List<TaskModel> taskList;
  TaskListVm({
    required this.taskList,
  }) : super(equals: [
          taskList,
        ]);
}
