import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/task/controller/task_model.dart';

import 'task_model.dart';

@immutable
class TaskState {
  final IList<TaskModel>? taskIList;
  final IList<TaskModel>? taskIListArchived;
  final TaskModel? taskCurrent;
  const TaskState({
    this.taskCurrent,
    this.taskIList,
    this.taskIListArchived,
  });
  factory TaskState.initialState() => TaskState(
        taskCurrent: null,
        taskIList: IList(),
        taskIListArchived: IList(),
      );
  TaskState copyWith({
    TaskModel? taskCurrent,
    IList<TaskModel>? taskIList,
    IList<TaskModel>? taskIListArchived,
    bool taskCurrentSetNull = false,
  }) {
    return TaskState(
      taskCurrent: taskCurrentSetNull ? null : taskCurrent ?? this.taskCurrent,
      taskIList: taskIList ?? this.taskIList,
      taskIListArchived: taskIListArchived ?? this.taskIListArchived,
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
        other.taskIList == taskIList &&
        other.taskIListArchived == taskIListArchived;
  }

  @override
  int get hashCode =>
      taskCurrent.hashCode ^ taskIList.hashCode ^ taskIListArchived.hashCode;
}
