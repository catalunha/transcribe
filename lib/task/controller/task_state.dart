import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/task/controller/task_model.dart';

import 'task_model.dart';

class TaskState {
  final IList<TaskModel>? taskIList;
  final TaskModel? taskCurrent;
  TaskState({
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
    return TaskState(
      taskCurrent: taskCurrent ?? this.taskCurrent,
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
        other.taskCurrent == taskCurrent &&
        other.taskIList == taskIList;
  }

  @override
  int get hashCode => taskCurrent.hashCode ^ taskIList.hashCode;
}
