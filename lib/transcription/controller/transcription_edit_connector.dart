import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/transcription/controller/transcription_action.dart';

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
        store.dispatch(SetTaskCurrentTranscriptionAction(id: addOrEditId));
      },
      vm: () => TranscriptionEditFactory(this),
      builder: (context, vm) => TranscriptionEdit(
        phraseAudio: vm.phraseAudio,
        phraseUnordened: vm.phraseUnordened,
        phraseCorrect: vm.phraseCorrect,
        onNewOrder: vm.onNewOrder,
        onSave: vm.onSave,
        onNotSave: vm.onNotSave,
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
        phraseCorrect:
            state.taskState.taskCurrent!.copyWith().phrase!.phraseList,
        onNewOrder: (List<String> newOrder) {
          dispatch(SetNewOrderTranscriptionAction(newOrder: newOrder));
        },
        onSave: () {
          dispatch(UpdateDocTranscriptionAction());
        },
        onNotSave: () {
          dispatch(ResetPhraseCurrentTranscriptionAction());
        },
      );

  List<String> disorderPhrase() {
    TaskModel taskModel = state.taskState.taskCurrent!.copyWith();
    String userId = state.userState.userCurrent!.id;

    Transcription transcription = taskModel.transcriptionMap![userId]!;
    return transcription.phraseOrdered!;
  }
}

class TranscriptionEditVm extends Vm {
  final List<String> phraseCorrect;
  final List<String> phraseUnordened;
  final String phraseAudio;
  final Function(List<String>) onNewOrder;
  final Function() onSave;
  final Function() onNotSave;
  TranscriptionEditVm({
    required this.phraseCorrect,
    required this.phraseUnordened,
    required this.phraseAudio,
    required this.onNewOrder,
    required this.onSave,
    required this.onNotSave,
  }) : super(equals: [
          phraseCorrect,
          phraseUnordened,
          phraseAudio,
        ]);
}
