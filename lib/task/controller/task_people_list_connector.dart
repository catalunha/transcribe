import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/transcription/controller/transcription_model.dart';

import '../../app_state.dart';
import '../task_people_list.dart';
import 'task_action.dart';

class TaskPeopleListConnector extends StatelessWidget {
  final String taskId;

  const TaskPeopleListConnector({Key? key, required this.taskId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TaskListVm>(
      vm: () => TaskListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTranscriptionsTaskAction(taskId: taskId));
      },
      builder: (context, vm) => TaskPeopleList(
        transcriptionIList: vm.transcriptionIList,
      ),
    );
  }
}

class TaskListVmFactory extends VmFactory<AppState, TaskPeopleListConnector> {
  TaskListVmFactory(widget) : super(widget);
  @override
  TaskListVm fromStore() => TaskListVm(
        transcriptionIList: state.transcriptionState.transcriptionIList!,
      );
}

class TaskListVm extends Vm {
  final IList<TranscriptionModel> transcriptionIList;
  TaskListVm({
    required this.transcriptionIList,
  }) : super(equals: [
          transcriptionIList,
        ]);
}
