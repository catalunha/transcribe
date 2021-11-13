import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
        taskIList: vm.taskIList,
      ),
    );
  }
}

class TaskListVmFactory extends VmFactory<AppState, TaskListConnector> {
  TaskListVmFactory(widget) : super(widget);
  @override
  TaskListVm fromStore() => TaskListVm(
        taskIList: state.taskState.taskIList!,
      );
}

class TaskListVm extends Vm {
  final IList<TaskModel> taskIList;
  TaskListVm({
    required this.taskIList,
  }) : super(equals: [
          taskIList,
        ]);
}
