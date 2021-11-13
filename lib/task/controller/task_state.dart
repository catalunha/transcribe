import 'package:flutter/foundation.dart';
import 'package:transcribe/task/controller/task_model.dart';

import 'task_model.dart';

class TaskState {
  final List<TaskModel>? taskList;
  final TaskModel? taskCurrent;
  TaskState({
    this.taskCurrent,
    this.taskList,
  });
  factory TaskState.initialState() => TaskState(
        taskCurrent: null,
        taskList: [],
      );
  TaskState copyWith({
    TaskModel? taskCurrent,
    List<TaskModel>? taskList,
    bool taskPhraseCurrentSetNull = false,
    bool taskPhraseListSetNull = false,
  }) {
    return TaskState(
      taskCurrent:
          taskPhraseCurrentSetNull ? null : taskCurrent ?? this.taskCurrent,
      taskList: taskList ?? this.taskList,
    );
  }

  @override
  String toString() =>
      'TaskState(taskCurrent: $taskCurrent, taskList: $taskList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskState &&
        other.taskCurrent == taskCurrent &&
        listEquals(other.taskList, taskList);
  }

  @override
  int get hashCode => taskCurrent.hashCode ^ taskList.hashCode;
}
