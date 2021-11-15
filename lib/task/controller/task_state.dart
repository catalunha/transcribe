import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/task/controller/task_model.dart';

import 'task_model.dart';

@immutable
class TaskState {
  // defaultConfig = ConfigList(isDeepEquals: false, cacheHashCode: false);
  final IList<TaskModel>? taskIList;
  final TaskModel? taskCurrent;
  const TaskState({
    this.taskCurrent,
    this.taskIList,
  });
  factory TaskState.initialState() => TaskState(
        taskCurrent: null,
        taskIList: IList(),
      );
  TaskState copyWith({
    TaskModel? taskCurrent,
    IList<TaskModel>? taskIList,
    bool taskPhraseCurrentSetNull = false,
    bool taskPhraseListSetNull = false,
  }) {
    // if (taskIList != null) {
    //   for (var task in taskIList) {
    //     print('copyWith list : $task');
    //   }
    // }
    // if (taskIList == null || taskIList.isEmpty) {
    //   print('copyWith list : null');
    // }
    // print('copyWith current: $taskCurrent');
    // if (this.taskIList != null) {
    //   for (var task in this.taskIList!) {
    //     print('this list : $task');
    //   }
    // }
    // if (this.taskIList == null || this.taskIList!.isEmpty) {
    //   print('this list : null');
    // }
    // print('this current: ${this.taskCurrent}');

    return TaskState(
      taskCurrent:
          taskPhraseCurrentSetNull ? null : taskCurrent ?? this.taskCurrent,
      taskIList: taskIList ?? this.taskIList,
    );
  }

  @override
  String toString() =>
      'TaskState(taskCurrent: $taskCurrent, taskList: $taskIList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskState &&
        runtimeType == other.runtimeType &&
        other.taskCurrent == taskCurrent &&
        other.taskIList == taskIList;
  }

  @override
  int get hashCode => taskCurrent.hashCode ^ taskIList.hashCode;
}
