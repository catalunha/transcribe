import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../transcription_edit.dart';
import '../transcription_edit.dart';

class TranscriptionEditConnector extends StatelessWidget {
  final String addOrEditId;
  const TranscriptionEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TranscriptionEditVm>(
      onInit: (store) {
        store.dispatch(SetTaskCurrentTaskAction(id: addOrEditId));
      },
      vm: () => TranscriptionEditFactory(this),
      builder: (context, vm) => TranscriptionEdit(
        phraseAudio: vm.phraseAudio,
        phraseUnordened: vm.phraseUnordened,
      ),
    );
  }
}

class TranscriptionEditFactory
    extends VmFactory<AppState, TranscriptionEditConnector> {
  TranscriptionEditFactory(widget) : super(widget);
  @override
  TranscriptionEditVm fromStore() => TranscriptionEditVm(
        phraseAudio: state.taskState.taskCurrent!.phrase!.phraseAudio,
        phraseUnordened: disorderPhrase(),
      );

  List<String> disorderPhrase() {
    List<String> temp = state.taskState.taskCurrent!.phrase!.phraseList;
    temp.sort();
    return temp;
  }
}

class TranscriptionEditVm extends Vm {
  final List<String> phraseUnordened;
  final String phraseAudio;
  TranscriptionEditVm(
      {required this.phraseUnordened, required this.phraseAudio})
      : super(equals: [
          phraseUnordened,
          phraseAudio,
        ]);
}
