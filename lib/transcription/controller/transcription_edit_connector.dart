import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/transcription/controller/transcription_action.dart';

import '../../app_state.dart';
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
        store.dispatch(
            SetTranscriptionCurrentTranscriptionAction(id: addOrEditId));
      },
      onDispose: (store) {
        store.dispatch(SetNulTranscriptioCurrentTeamAction());
      },
      vm: () => TranscriptionEditFactory(this),
      builder: (context, vm) => TranscriptionEdit(
        phraseAudio: vm.phraseAudio,
        phraseUnordened: vm.phraseUnordened,
        phraseCorrect: vm.phraseCorrect,
        onNewOrder: vm.onNewOrder,
        onSave: vm.onSave,
      ),
    );
  }
}

class TranscriptionEditFactory
    extends VmFactory<AppState, TranscriptionEditConnector> {
  TranscriptionEditFactory(widget) : super(widget);
  @override
  TranscriptionEditVm fromStore() => TranscriptionEditVm(
        phraseAudio: state
            .transcriptionState.transcriptionCurrent!.task.phrase!.phraseAudio,
        phraseUnordened:
            state.transcriptionState.transcriptionCurrent!.phraseOrdered!,
        phraseCorrect: state
            .transcriptionState.transcriptionCurrent!.task.phrase!.phraseList,
        onNewOrder: (List<String> newOrder) {
          dispatch(SetNewOrderTranscriptionAction(newOrder: newOrder));
        },
        onSave: () {
          dispatch(UpdateDocTranscriptionAction());
        },
      );

  // List<String> disorderPhrase() {
  //   String userId = state.userState.userCurrent!.id;

  //   Transcription transcription =
  //       state.taskState.taskCurrent!.transcriptionMap![userId]!;
  //   return transcription.phraseOrdered!;
  // }
}

class TranscriptionEditVm extends Vm {
  final List<String> phraseCorrect;
  final List<String> phraseUnordened;
  final String phraseAudio;
  final Function(List<String>) onNewOrder;
  final Function() onSave;
  TranscriptionEditVm({
    required this.phraseCorrect,
    required this.phraseUnordened,
    required this.phraseAudio,
    required this.onNewOrder,
    required this.onSave,
  }) : super(equals: [
          phraseCorrect,
          phraseUnordened,
          phraseAudio,
        ]);
}
