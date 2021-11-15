import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../task_list.dart';
import '../task_list_archived.dart';
import 'task_action.dart';

class TaskListArchivedConnector extends StatelessWidget {
  const TaskListArchivedConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVm>(
      vm: () => TaskListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTaskAction(isArchived: true));
      },
      builder: (context, vm) => TaskArchivedList(
        taskIList: vm.taskIList,
        onArchive: vm.onArchive,
        onDelete: vm.onDelete,
      ),
    );
  }
}

class TaskListVmFactory extends VmFactory<AppState, TaskListArchivedConnector> {
  TaskListVmFactory(widget) : super(widget);
  @override
  TaskListVm fromStore() => TaskListVm(
        taskIList: state.taskState.taskIListArchived!,
        onArchive: (String taskId) =>
            dispatch(ArchiveDocTaskAction(taskId: taskId, isArchived: false)),
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
