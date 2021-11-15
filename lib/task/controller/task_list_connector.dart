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
        store.dispatch(StreamDocsTaskAction(isArchived: false));
      },
      builder: (context, vm) => TaskList(
        taskIList: vm.taskIList,
        onArchive: vm.onArchive,
        onDelete: vm.onDelete,
      ),
    );
  }
}

class TaskListVmFactory extends VmFactory<AppState, TaskListConnector> {
  TaskListVmFactory(widget) : super(widget);
  @override
  TaskListVm fromStore() => TaskListVm(
        taskIList: state.taskState.taskIList!,
        onArchive: (String taskId) =>
            dispatch(ArchiveDocTaskAction(taskId: taskId)),
        onDelete: (String taskId) =>
            dispatch(DeleteDocTaskAction(taskId: taskId)),
      );
}

class TaskListVm extends Vm {
  final IList<TaskModel> taskIList;
  final Function(String) onArchive;
  final Function(String) onDelete;

  TaskListVm({
    required this.taskIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(equals: [
          taskIList,
        ]);
}
